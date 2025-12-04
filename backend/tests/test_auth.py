from fastapi.testclient import TestClient


def test_register_user(client: TestClient):
    """Test user registration"""
    response = client.post(
        "/api/v1/auth/register",
        json={
            "email": "test@example.com",
            "username": "testuser",
            "password": "testpassword123",
            "full_name": "Test User"
        }
    )
    assert response.status_code == 201
    data = response.json()
    assert data["email"] == "test@example.com"
    assert data["username"] == "testuser"
    assert "id" in data


def test_register_duplicate_user(client: TestClient):
    """Test registering duplicate user"""
    user_data = {
        "email": "duplicate@example.com",
        "username": "duplicate",
        "password": "password123"
    }
    
    # First registration should succeed
    response = client.post("/api/v1/auth/register", json=user_data)
    assert response.status_code == 201
    
    # Second registration should fail
    response = client.post("/api/v1/auth/register", json=user_data)
    assert response.status_code == 400


def test_login(client: TestClient):
    """Test user login"""
    # Register user
    client.post(
        "/api/v1/auth/register",
        json={
            "email": "login@example.com",
            "username": "loginuser",
            "password": "loginpass123"
        }
    )
    
    # Login
    response = client.post(
        "/api/v1/auth/login",
        data={"username": "loginuser", "password": "loginpass123"}
    )
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert data["token_type"] == "bearer"


def test_login_invalid_credentials(client: TestClient):
    """Test login with invalid credentials"""
    response = client.post(
        "/api/v1/auth/login",
        data={"username": "nonexistent", "password": "wrongpass"}
    )
    assert response.status_code == 401
