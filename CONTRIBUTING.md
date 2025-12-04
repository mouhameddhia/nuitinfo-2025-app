# Contributing to Nuit de l'Info Project

## Team Workflow

### Branch Strategy
- `main` - Production-ready code
- `develop` - Integration branch
- `feature/<name>` - Feature branches
- `fix/<name>` - Bug fixes

### Getting Started

1. **Pull latest changes:**
   ```powershell
   git checkout develop
   git pull origin develop
   ```

2. **Create feature branch:**
   ```powershell
   git checkout -b feature/your-feature-name
   ```

3. **Make changes and commit:**
   ```powershell
   git add .
   git commit -m "feat: description"
   ```

4. **Push and create PR:**
   ```powershell
   git push origin feature/your-feature-name
   ```

5. **Create Pull Request on GitHub**
   - Target: `develop` branch
   - Add description
   - Request review from teammate

6. **After review and CI passes, merge PR**

### Commit Message Convention

Format: `<type>: <description>`

Types:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation
- `style:` - Formatting
- `refactor:` - Code restructuring
- `test:` - Tests
- `chore:` - Maintenance

Examples:
```
feat: add user authentication
fix: resolve CORS issue
docs: update README with setup instructions
```

### Code Review Guidelines

**For Authors:**
- Keep PRs small and focused
- Write clear PR descriptions
- Test your changes locally
- Run linting and tests before pushing
- Respond to review comments promptly

**For Reviewers:**
- Review within 30 minutes during competition
- Check for bugs, logic errors
- Ensure code follows project conventions
- Test locally if possible
- Be constructive and kind

### Avoiding Merge Conflicts

1. **Pull frequently:**
   ```powershell
   git checkout develop
   git pull origin develop
   git checkout your-branch
   git merge develop
   ```

2. **Communicate with teammate:**
   - Avoid working on same files simultaneously
   - Coordinate on shared components
   - Use VS Code Live Share for pair programming

3. **If conflicts occur:**
   ```powershell
   # Update your branch
   git checkout your-branch
   git fetch origin
   git merge origin/develop
   
   # Resolve conflicts in VS Code
   # After resolving:
   git add .
   git commit -m "merge: resolve conflicts with develop"
   git push origin your-branch
   ```

### File Organization

**Backend:**
- Models: `backend/app/models/`
- API endpoints: `backend/app/api/v1/`
- Business logic: `backend/app/services/`
- Tests: `backend/tests/`

**Frontend:**
- Components: `frontend/src/components/`
- Pages: `frontend/src/pages/`
- Services: `frontend/src/services/`
- Types: `frontend/src/types/`
- Tests: `frontend/src/__tests__/`

### Testing Requirements

**Before pushing:**
```powershell
# Backend
cd backend
pytest

# Frontend
cd frontend
npm test
```

**Before merging to main:**
- All tests pass
- Code coverage maintained
- Linting passes
- Manual testing done

### Communication

- **Quick questions:** Use GitHub PR comments
- **Planning:** Brief standup before starting
- **Blockers:** Communicate immediately
- **Progress:** Update TODO list in README

### During Competition

**Speed vs Quality:**
- Prioritize working features
- Write tests for critical paths
- Document complex logic
- Refactor later if time permits

**Task Division:**
- Backend person: API, database, auth
- Frontend person: UI, routing, state
- Collaborate on integration
- Help each other when blocked

**Checkpoints:**
Every 2 hours:
1. Merge working features to develop
2. Test integration
3. Deploy to staging/production
4. Plan next features

Good luck! 🚀
