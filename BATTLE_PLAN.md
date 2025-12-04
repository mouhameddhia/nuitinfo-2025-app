# 🌙 NUIT DE L'INFO 2025 - BATTLE PLAN

## ⏰ Timeline Template

### Phase 1: Préparation (19h00 - 19h30)
- [ ] Lire le sujet attentivement
- [ ] Identifier les fonctionnalités principales
- [ ] Choisir les défis (max 5)
- [ ] Diviser les tâches entre coéquipiers
- [ ] Créer les branches Git

### Phase 2: MVP Core (19h30 - 23h00)
**Objectif: Application fonctionnelle de base**
- [ ] Adapter les modèles de données au sujet
- [ ] Créer les endpoints API principaux
- [ ] Implémenter les pages principales
- [ ] Tester l'intégration backend-frontend
- [ ] Premier déploiement

### Phase 3: Fonctionnalités (23h00 - 03h00)
**Objectif: Compléter les features demandées**
- [ ] Implémenter les fonctionnalités spécifiques
- [ ] Ajouter la logique métier
- [ ] Intégrer les données/API externes si nécessaire
- [ ] Tests fonctionnels

### Phase 4: Défis & Polish (03h00 - 06h00)
**Objectif: Répondre aux défis et améliorer**
- [ ] Travailler sur les défis choisis
- [ ] Améliorer l'UI/UX
- [ ] Optimisations performance
- [ ] Documentation
- [ ] Tests finaux

### Phase 5: Finalisation (06h00 - 07h00)
**Objectif: Dernier polish et soumission**
- [ ] Vérifier tous les critères
- [ ] Screenshots et vidéo démo
- [ ] README final
- [ ] Déploiement production
- [ ] Soumettre le projet

## 🎯 Quick Reference

### Démarrage Rapide
```powershell
# Option 1: Docker (Recommandé)
docker-compose up -d
# Frontend: http://localhost:5173
# Backend: http://localhost:8000
# Docs: http://localhost:8000/docs

# Option 2: Local
# Terminal 1 (Backend)
cd backend; .\venv\Scripts\Activate.ps1; uvicorn app.main:app --reload

# Terminal 2 (Frontend)
cd frontend; npm run dev
```

### Commandes Essentielles
```powershell
# Créer une migration
cd backend; alembic revision --autogenerate -m "add feature"
cd backend; alembic upgrade head

# Tests rapides
cd backend; pytest
cd frontend; npm test

# Format code
cd backend; black app/; isort app/
cd frontend; npm run lint -- --fix

# Voir les logs Docker
docker-compose logs -f backend
docker-compose logs -f frontend
```

### Structure Fichiers Clés

**Backend - Ajouter un endpoint:**
1. Créer modèle: `backend/app/models/models.py`
2. Créer schéma: `backend/app/schemas/schemas.py`
3. Créer endpoint: `backend/app/api/v1/your_feature.py`
4. Ajouter route: `backend/app/main.py`

**Frontend - Ajouter une page:**
1. Créer page: `frontend/src/pages/YourPage.tsx`
2. Créer styles: `frontend/src/pages/YourPage.module.css`
3. Ajouter route: `frontend/src/App.tsx`
4. Créer service si API: `frontend/src/services/yourService.ts`

## 🚀 Déploiement Rapide

### Backend (Render.com)
1. Push code sur GitHub
2. Créer nouveau Web Service sur Render
3. Connecter repo GitHub
4. Build command: `pip install -r requirements.txt`
5. Start command: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
6. Ajouter variables d'environnement (DATABASE_URL, SECRET_KEY)
7. Créer base PostgreSQL sur Render
8. Déployer

### Frontend (Vercel)
1. Push code sur GitHub
2. Importer projet sur Vercel
3. Framework: Vite
4. Root directory: `frontend`
5. Build command: `npm run build`
6. Output directory: `dist`
7. Ajouter variable: `VITE_API_URL` (URL backend Render)
8. Deploy

### Alternative: Railway.app
- Plus simple, déploie backend + frontend + DB en un clic
- Connecter GitHub repo
- Railway détecte automatiquement la config

## 📋 Checklist Défis Communs

### Défi Accessibilité
- [ ] Attributs ARIA sur éléments interactifs
- [ ] Navigation clavier fonctionnelle
- [ ] Contraste couleurs suffisant (WCAG AA)
- [ ] Alt text sur images
- [ ] Labels sur formulaires
- [ ] Test avec lecteur d'écran

### Défi Design/UX
- [ ] Interface cohérente et professionnelle
- [ ] Responsive (mobile, tablet, desktop)
- [ ] Animations fluides
- [ ] Feedback utilisateur (loading, erreurs)
- [ ] Dark mode (bonus)

### Défi Performance
- [ ] Lazy loading images
- [ ] Code splitting
- [ ] Caching approprié
- [ ] Optimisation requêtes DB
- [ ] Compression des assets
- [ ] Lighthouse score > 90

### Défi Sécurité
- [ ] Validation inputs côté serveur
- [ ] Protection CSRF
- [ ] Rate limiting
- [ ] Sanitization des données
- [ ] HTTPS activé
- [ ] Headers sécurité (CORS, CSP)

### Défi Code Quality
- [ ] Tests unitaires (coverage > 70%)
- [ ] Code formaté (black, prettier)
- [ ] Linting sans erreurs
- [ ] Documentation API (Swagger)
- [ ] README complet
- [ ] Git commits clairs

## 🛠️ Troubleshooting Rapide

**Backend ne démarre pas:**
```powershell
# Vérifier DB
docker-compose up -d db
# Migrations
cd backend; alembic upgrade head
# Vérifier .env
cat backend\.env
```

**Frontend erreurs CORS:**
```powershell
# Vérifier CORS_ORIGINS dans backend/.env
# Restart backend
docker-compose restart backend
```

**Conflits Git:**
```powershell
git fetch origin
git merge origin/develop
# Résoudre dans VS Code
git add .
git commit -m "merge: resolve conflicts"
```

## 💡 Tips Performance Pendant la Nuit

1. **Commits fréquents** - Toutes les 30 min
2. **Déployer tôt** - Dès le MVP fonctionnel
3. **Communication** - Update status régulièrement
4. **Pause courtes** - 5 min toutes les 2h
5. **Focus MVP** - Features demandées d'abord
6. **Documentation en parallèle** - Pas à la fin
7. **Tests essentiels** - Paths critiques seulement
8. **No perfectionism** - Working > Perfect

## 🎨 Ressources Utiles

**Icons & Images:**
- Heroicons: https://heroicons.com
- Unsplash: https://unsplash.com
- Flaticon: https://flaticon.com

**UI Components:**
- Tailwind UI: https://tailwindui.com
- shadcn/ui: https://ui.shadcn.com
- Headless UI: https://headlessui.com

**Inspiration:**
- Dribbble: https://dribbble.com
- Awwwards: https://awwwards.com

**Docs:**
- FastAPI: https://fastapi.tiangolo.com
- React: https://react.dev
- TypeScript: https://typescriptlang.org/docs

## 📞 Emergency Contacts

**Coéquipier:**
- Nom: _______________
- Discord: _______________
- Tel: _______________

**Role Division:**
- Backend lead: _______________
- Frontend lead: _______________
- Integration: Both
- Deployment: _______________
- Documentation: _______________

## 🏆 Success Criteria

**Minimum (Must Have):**
- [ ] Application fonctionnelle accessible en ligne
- [ ] Répond au sujet principal
- [ ] Auth fonctionne
- [ ] Au moins 3 features majeures
- [ ] Responsive
- [ ] README complet

**Good (Should Have):**
- [ ] 2-3 défis complétés
- [ ] Tests > 50% coverage
- [ ] Performance correcte
- [ ] UI professionnelle
- [ ] Documentation API

**Excellent (Nice to Have):**
- [ ] 4-5 défis complétés
- [ ] Tests > 80% coverage
- [ ] CI/CD configuré
- [ ] Monitoring/Logs
- [ ] Features innovantes

---

**🌟 Bon courage et amusez-vous bien ! 🌟**

Remember: L'objectif est d'apprendre et de s'amuser, pas juste de gagner !
