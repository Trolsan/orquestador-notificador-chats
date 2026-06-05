from pydantic import BaseModel, Field


class WebhookRequest(BaseModel):
    user: str = Field(..., min_length=1, examples=["nombre"])
    message: str = Field(..., min_length=1, examples=["texto del mensaje"])


class WebhookResponse(BaseModel):
    alert: bool
