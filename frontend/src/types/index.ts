export interface User {
  id: number
  email: string
  username: string
  full_name?: string
  is_active: boolean
  is_superuser: boolean
  created_at: string
}

export interface UserCreate {
  email: string
  username: string
  password: string
  full_name?: string
}

export interface UserLogin {
  username: string
  password: string
}

export interface Token {
  access_token: string
  token_type: string
}

export interface Project {
  id: number
  title: string
  description?: string
  owner_id: number
  is_active: boolean
  created_at: string
  updated_at: string
}

export interface ProjectCreate {
  title: string
  description?: string
}
