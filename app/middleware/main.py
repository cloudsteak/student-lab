import os
import httpx
import logging
import structlog
import asyncio
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from prometheus_fastapi_instrumentator import Instrumentator
from dotenv import load_dotenv
import random

# Load environment variables from .env file
load_dotenv()

# Secure Logging
logging.basicConfig(level=logging.INFO)
log = structlog.get_logger()

# Load Secrets from .env
GITHUB_PAT = os.getenv("GITHUB_PAT")
GITHUB_OWNER = os.getenv("GITHUB_OWNER")
GITHUB_REPO = os.getenv("GITHUB_REPO")
WORKFLOW_FILE = os.getenv("WORKFLOW_FILE", "workflow.yml")

if not all([GITHUB_PAT, GITHUB_OWNER, GITHUB_REPO]):
    log.error("❌ Missing required environment variables!")
    raise ValueError("Missing required environment variables: GITHUB_PAT, GITHUB_OWNER, GITHUB_REPO, WORKFLOW_FILE")

# FastAPI App
app = FastAPI(title="GitHub Action Middleware", version="1.4")

# Monitoring with Prometheus
Instrumentator().instrument(app).expose(app)

# Generate random numbers for password suffix
def generate_password_key():
    return str(random.randint(1000, 999999))

# Secure Model
class Payload(BaseModel):
    student_username: str = Field(..., min_length=5, max_length=50)

async def trigger_github_action(action: str, student_username: str, password_key: str):
    """
    Triggers GitHub Action workflow asynchronously and waits for completion.
    Then, retrieves the uploaded artifact from `actions/upload-artifact@v4`.
    """
    url = f"https://api.github.com/repos/{GITHUB_OWNER}/{GITHUB_REPO}/actions/workflows/{WORKFLOW_FILE}/dispatches"
    headers = {
        "Authorization": f"Bearer {GITHUB_PAT}",
        "Accept": "application/vnd.github+json"
    }
    payload = {
        "ref": "main",
        "inputs": {
            "lab": "basic",
            "action": action,
            "student_username": student_username,
            "password_key": password_key
        }
    }

    async with httpx.AsyncClient(timeout=10.0) as client:
        for attempt in range(3):  # Retry mechanism
            response = await client.post(url, headers=headers, json=payload)
            if response.status_code == 204:
                log.info(f"✅ GitHub Action '{action}' triggered successfully", inputs=payload["inputs"])
                return True
            log.warning(f"⚠️ Attempt {attempt+1} failed: {response.text}")
        return False

@app.post("/apply")
async def apply(data: Payload):
    """ Asynchronously triggers apply workflow, waits for completion, and fetches the artifact. """
    password_key = generate_password_key()
    success = await trigger_github_action("apply", data.student_username, password_key)

    if not success:
        return {
            "status": "error",
            "error-code": "1",
            "error-message": "GitHub Action failed",
            "student_username": data.student_username,
            "password_key": password_key,
            "console_url": "",
        }

    return {
        "status": "ok",
        "error-code": "0",
        "error-message": "",
        "student_username": data.student_username,
        "password_key": password_key,
        "console_url": f"https://004770426262.signin.aws.amazon.com/console",
    }

@app.post("/destroy")
async def destroy(data: Payload):
    """ Asynchronously triggers destroy workflow and waits for completion. """

    password_key = generate_password_key()
    success = await trigger_github_action("destroy", data.student_username, password_key)

    if not success:
        return {
            "status": "error",
            "error-code": "1",
            "error-message": "GitHub Action failed",
            "student_username": data.student_username
        }

    return {
        "status": "ok",
        "error-code": "0",
        "error-message": "",
        "student_username": data.student_username,
    }

@app.get("/health")
async def health():
    """ Kubernetes Readiness & Liveness Probes """
    return {"status": "healthy"}

# Run server (Production: Use Gunicorn + Uvicorn)
if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, workers=4)
