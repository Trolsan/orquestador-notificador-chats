ALERT_KEYWORDS: tuple[str, ...] = ("urgente", "error", "ayuda")


def evaluate_alert(message: str) -> bool:
    """Return True if the message contains any alert keyword (case-insensitive)."""
    normalized = message.casefold()
    return any(keyword in normalized for keyword in ALERT_KEYWORDS)
