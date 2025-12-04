import api from './api'
import type { User, UserCreate, UserLogin, Token } from '@/types'

export const authService = {
  async register(data: UserCreate): Promise<User> {
    const response = await api.post<User>('/auth/register', data)
    return response.data
  },

  async login(data: UserLogin): Promise<Token> {
    const response = await api.post<Token>('/auth/login/json', data)
    localStorage.setItem('access_token', response.data.access_token)
    return response.data
  },

  logout() {
    localStorage.removeItem('access_token')
  },

  async getCurrentUser(): Promise<User> {
    const response = await api.get<User>('/users/me')
    return response.data
  },

  isAuthenticated(): boolean {
    return !!localStorage.getItem('access_token')
  },
}
