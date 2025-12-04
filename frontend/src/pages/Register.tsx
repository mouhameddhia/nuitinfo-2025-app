import { useState } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import { authService } from '@/services/authService'
import styles from './Auth.module.css'

function Register() {
  const navigate = useNavigate()
  const [formData, setFormData] = useState({
    email: '',
    username: '',
    password: '',
    full_name: '',
  })
  const [error, setError] = useState('')
  const [isLoading, setIsLoading] = useState(false)

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    })
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')
    setIsLoading(true)

    try {
      await authService.register(formData)
      navigate('/login')
    } catch (err: any) {
      setError(err.response?.data?.detail || 'Registration failed. Please try again.')
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className={styles.authContainer}>
      <div className={styles.authCard}>
        <h1>Create Account</h1>
        <form onSubmit={handleSubmit} className={styles.form}>
          {error && <div className={styles.error}>{error}</div>}
          
          <div className={styles.formGroup}>
            <label htmlFor="email">Email</label>
            <input
              type="email"
              id="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              required
              autoComplete="email"
            />
          </div>

          <div className={styles.formGroup}>
            <label htmlFor="username">Username</label>
            <input
              type="text"
              id="username"
              name="username"
              value={formData.username}
              onChange={handleChange}
              required
              autoComplete="username"
            />
          </div>

          <div className={styles.formGroup}>
            <label htmlFor="full_name">Full Name (optional)</label>
            <input
              type="text"
              id="full_name"
              name="full_name"
              value={formData.full_name}
              onChange={handleChange}
              autoComplete="name"
            />
          </div>

          <div className={styles.formGroup}>
            <label htmlFor="password">Password</label>
            <input
              type="password"
              id="password"
              name="password"
              value={formData.password}
              onChange={handleChange}
              required
              autoComplete="new-password"
              minLength={6}
            />
          </div>

          <button type="submit" disabled={isLoading} className={styles.submitBtn}>
            {isLoading ? 'Creating account...' : 'Create Account'}
          </button>
        </form>

        <p className={styles.switchAuth}>
          Already have an account? <Link to="/login">Sign in here</Link>
        </p>
      </div>
    </div>
  )
}

export default Register
