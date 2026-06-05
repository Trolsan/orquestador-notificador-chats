# Workflows n8n

En la **Fase 6** se exportará aquí el flujo `workflow-orquestador.json` desde la interfaz de n8n.

**Payload esperado hacia la API:**

```json
{
  "user": "nombre",
  "message": "texto del mensaje"
}
```

**Endpoint destino:**

| Entorno | URL del HTTP Request |
|---------|----------------------|
| Docker Compose (n8n en contenedor) | `http://api:8000/webhook` |
| API local sin Docker | `http://localhost:8000/webhook` |
| Cypress / host → API en Docker | `http://localhost:8000/webhook` |

> **Importante:** Dentro del contenedor n8n, `localhost` apunta al propio n8n, no a la API.
