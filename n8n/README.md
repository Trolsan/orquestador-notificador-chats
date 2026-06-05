# Workflows n8n

Exportados listos para importar en n8n (Fase 6).

## Archivos

| Archivo | Descripción |
|---------|-------------|
| `workflow-orquestador.json` | **Manual Trigger** → Set Payload → POST API (demo sustentación) |
| `workflow-orquestador-webhook.json` | **Webhook POST** simulado → POST API |

## Payload hacia la API

```json
{
  "user": "nombre",
  "message": "texto del mensaje"
}
```

## URL del nodo HTTP Request

| Entorno | URL |
|---------|-----|
| Docker Compose (n8n en contenedor) | `http://api:8000/webhook` |
| n8n en host + API local | `http://localhost:8000/webhook` |

> Dentro del contenedor n8n, `localhost` apunta al propio n8n, **no** a la API.

## Importar y probar

Guía paso a paso: [docs/n8n-workflow.md](../docs/n8n-workflow.md).

```powershell
# Stack levantado
docker compose up -d

# Webhook (workflow activo en n8n)
.\scripts\test-n8n-webhook.ps1
```
