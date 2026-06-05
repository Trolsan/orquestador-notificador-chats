from fastapi import FastAPI

from app.api.routes.webhook import router as webhook_router

app = FastAPI(
    title="Orquestador Notificador de Chats",
    description="PoC API that evaluates chat messages for immediate attention.",
    version="0.1.0",
)

app.include_router(webhook_router)


@app.get("/health")
def health_check() -> dict[str, str]:
    """Lightweight health endpoint for Docker and cloud probes."""
    return {"status": "ok"}
