from fastapi import APIRouter

from app.api.schemas import WebhookRequest, WebhookResponse
from app.services.alert_evaluator import evaluate_alert

router = APIRouter(tags=["webhook"])


@router.post("/webhook", response_model=WebhookResponse)
def process_webhook(payload: WebhookRequest) -> WebhookResponse:
    """Evaluate an incoming message and return whether it requires immediate attention."""
    alert = evaluate_alert(payload.message)
    return WebhookResponse(alert=alert)
