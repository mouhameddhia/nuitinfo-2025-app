import { useEffect } from 'react'
import { useAuthStore } from '@/store/authStore'
import styles from './Dashboard.module.css'

function Dashboard() {
  const { user, checkAuth } = useAuthStore()

  useEffect(() => {
    checkAuth()
  }, [checkAuth])

  if (!user) {
    return <div>Loading...</div>
  }

  return (
    <div className={styles.dashboard}>
      <h1>Dashboard</h1>
      <p className={styles.welcome}>Welcome back, {user.full_name || user.username}! 👋</p>
      
      <div className={styles.grid}>
        <div className={styles.card}>
          <h2>📊 Quick Stats</h2>
          <p>Ready to implement your competition features here!</p>
        </div>

        <div className={styles.card}>
          <h2>🎯 Tasks</h2>
          <p>Add your task management features</p>
        </div>

        <div className={styles.card}>
          <h2>🔥 Activity</h2>
          <p>Track your recent activities</p>
        </div>

        <div className={styles.card}>
          <h2>⚙️ Settings</h2>
          <p>Configure your preferences</p>
        </div>
      </div>

      <div className={styles.info}>
        <h2>🚀 Competition Ready</h2>
        <p>
          This dashboard is ready to be customized with your competition-specific features.
          The authentication, routing, and state management are all set up!
        </p>
      </div>
    </div>
  )
}

export default Dashboard
