import pytest
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

@pytest.mark.asyncio
async def test_health():
    """ Test Health Check Endpoint """
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}

@pytest.mark.asyncio
async def test_apply_unauthorized():
    """ Test Unauthorized Apply Request """
    response = client.post("/apply", json={"param1": "value1", "param2": "value2", "param3": "value3"})
    assert response.status_code == 401
    assert response.json()["detail"] == "Unauthorized"

@pytest.mark.asyncio
async def test_destroy_unauthorized():
    """ Test Unauthorized Destroy Request """
    response = client.post("/destroy", json={"param1": "value1", "param2": "value2"})
    assert response.status_code == 401
    assert response.json()["detail"] == "Unauthorized"
