import { Outlet, Link } from 'react-router-dom'
import { useAuthStore } from '@/store/authStore'
import styles from './Layout.module.css'

function Layout() {
  const { isAuthenticated, user, logout } = useAuthStore()

  return (
    <div className={styles.layout}>
      <header className={styles.header}>
        <nav className={styles.nav}>
          <Link to="/" className={styles.logo}>
            Nuit de l'Info 2025
          </Link>
          <div className={styles.navLinks}>
            {isAuthenticated ? (
              <>
                <Link to="/dashboard">Dashboard</Link>
                <Link to="/profile">Profile ({user?.username})</Link>
                <button onClick={logout} className={styles.logoutBtn}>
                  Logout
                </button>
              </>
            ) : (
              <>
                <Link to="/login">Login</Link>
                <Link to="/register">Register</Link>
              </>
            )}
          </div>
        </nav>
      </header>
      <main className={styles.main}>
        <Outlet />
      </main>
      <footer className={styles.footer}>
        <p>&copy; 2025 Nuit de l'Info. Built with FastAPI + React + TypeScript</p>
      </footer>
    </div>
  )
}

export default Layout
