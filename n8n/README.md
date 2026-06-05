# Workflows n8n

En la **Fase 6** se exportará aquí el flujo `workflow-orquestador.json` desde la interfaz de n8n.

**Payload esperado hacia la API:**

```json
{
  "user": "nombre",
  "message": "texto del mensaje"
}
```

**Endpoint destino:** `POST /webhook` en el servicio `api` (Docker) o `http://localhost:8000` en desarrollo local.
