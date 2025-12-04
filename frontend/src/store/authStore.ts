import { create } from 'zustand'
import { authService } from '@/services/authService'
import type { User } from '@/types'

interface AuthState {
  user: User | null
  isAuthenticated: boolean
  isLoading: boolean
  setUser: (user: User | null) => void
  login: (username: string, password: string) => Promise<void>
  logout: () => void
  checkAuth: () => Promise<void>
}

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  isAuthenticated: authService.isAuthenticated(),
  isLoading: false,

  setUser: (user) => set({ user, isAuthenticated: !!user }),

  login: async (username, password) => {
    set({ isLoading: true })
    try {
      await authService.login({ username, password })
      const user = await authService.getCurrentUser()
      set({ user, isAuthenticated: true, isLoading: false })
    } catch (error) {
      set({ isLoading: false })
      throw error
    }
  },

  logout: () => {
    authService.logout()
    set({ user: null, isAuthenticated: false })
  },

  checkAuth: async () => {
    if (!authService.isAuthenticated()) {
      set({ user: null, isAuthenticated: false })
      return
    }

    try {
      const user = await authService.getCurrentUser()
      set({ user, isAuthenticated: true })
    } catch {
      authService.logout()
      set({ user: null, isAuthenticated: false })
    }
  },
}))
