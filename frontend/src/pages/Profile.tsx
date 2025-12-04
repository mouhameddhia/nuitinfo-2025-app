import { useEffect } from 'react'
import { useAuthStore } from '@/store/authStore'
import styles from './Profile.module.css'

function Profile() {
  const { user, checkAuth } = useAuthStore()

  useEffect(() => {
    checkAuth()
  }, [checkAuth])

  if (!user) {
    return <div>Loading...</div>
  }

  return (
    <div className={styles.profile}>
      <h1>Profile</h1>
      
      <div className={styles.card}>
        <div className={styles.avatar}>
          {user.username.charAt(0).toUpperCase()}
        </div>
        
        <div className={styles.info}>
          <h2>{user.full_name || user.username}</h2>
          <p className={styles.username}>@{user.username}</p>
          <p className={styles.email}>{user.email}</p>
        </div>
      </div>

      <div className={styles.details}>
        <h3>Account Details</h3>
        <div className={styles.detailGrid}>
          <div className={styles.detailItem}>
            <span className={styles.label}>User ID:</span>
            <span className={styles.value}>{user.id}</span>
          </div>
          <div className={styles.detailItem}>
            <span className={styles.label}>Status:</span>
            <span className={styles.value}>
              {user.is_active ? '✅ Active' : '❌ Inactive'}
            </span>
          </div>
          <div className={styles.detailItem}>
            <span className={styles.label}>Role:</span>
            <span className={styles.value}>
              {user.is_superuser ? '👑 Admin' : '👤 User'}
            </span>
          </div>
          <div className={styles.detailItem}>
            <span className={styles.label}>Member Since:</span>
            <span className={styles.value}>
              {new Date(user.created_at).toLocaleDateString()}
            </span>
          </div>
        </div>
      </div>

      <div className={styles.actions}>
        <button className={styles.btnPrimary}>Edit Profile</button>
        <button className={styles.btnSecondary}>Change Password</button>
      </div>
    </div>
  )
}

export default Profile
