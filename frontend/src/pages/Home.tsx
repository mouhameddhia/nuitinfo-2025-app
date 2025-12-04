import { Link } from 'react-router-dom'
import styles from './Home.module.css'

function Home() {
  return (
    <div className={styles.home}>
      <div className={styles.hero}>
        <h1>Nuit de l'Info 2025</h1>
        <p>Ready to build amazing web applications during the night!</p>
        <div className={styles.cta}>
          <Link to="/register" className={styles.btnPrimary}>
            Get Started
          </Link>
          <Link to="/login" className={styles.btnSecondary}>
            Sign In
          </Link>
        </div>
      </div>

      <div className={styles.features}>
        <h2>Tech Stack</h2>
        <div className={styles.grid}>
          <div className={styles.card}>
            <h3>⚡ FastAPI</h3>
            <p>Modern, fast Python backend with automatic API documentation</p>
          </div>
          <div className={styles.card}>
            <h3>⚛️ React + TypeScript</h3>
            <p>Type-safe frontend with modern React and Vite</p>
          </div>
          <div className={styles.card}>
            <h3>🐘 PostgreSQL</h3>
            <p>Robust relational database for production use</p>
          </div>
          <div className={styles.card}>
            <h3>🔐 JWT Auth</h3>
            <p>Secure authentication with JSON Web Tokens</p>
          </div>
          <div className={styles.card}>
            <h3>🐳 Docker</h3>
            <p>Containerized development and deployment</p>
          </div>
          <div className={styles.card}>
            <h3>🧪 Testing</h3>
            <p>Comprehensive testing with pytest and vitest</p>
          </div>
        </div>
      </div>

      <div className={styles.info}>
        <h2>Ready for Competition</h2>
        <p>
          This application is pre-configured and ready to be customized for the competition topic.
          All the boilerplate is done - focus on implementing the unique features!
        </p>
      </div>
    </div>
  )
}

export default Home
