# Orquestador Notificador de Chats

Prueba de concepto (PoC) para un servicio que procesa mensajes simulados, evalúa si requieren atención inmediata y expone una API desplegable en AWS. Incluye orquestación con **n8n**, contenedorización con **Docker**, pruebas con **Cypress** y evidencia de uso de **IA**.

> **Estado del proyecto:** Fase 2 completada (API FastAPI). Pendiente: Docker, n8n, Cypress y AWS.

## Arquitectura (resumen)

```text
[n8n trigger] --POST JSON--> [FastAPI POST /webhook] --> {"alert": true|false}
[Cypress]     --POST directo (sin n8n)----------------^
[Internet]    --POST----------------------------------^  (solo API en AWS)
```

Documentación detallada: [ARCHITECTURE.md](./ARCHITECTURE.md).

## Requisitos previos

| Herramienta | Uso |
|-------------|-----|
| Python 3.11+ | API FastAPI (fases 2+) |
| Docker & Docker Compose | API + n8n local (fases 4–5) |
| Node.js 18+ | Cypress (fase 7) |
| Cuenta AWS | Despliegue de la API (fase 8) |

## Estructura del repositorio

```text
orquestador-notificador-chats/
├── backend/          # API FastAPI
├── n8n/              # Workflow exportado (.json)
├── cypress/          # Pruebas E2E de contrato API
├── docs/             # Guías complementarias (AWS, etc.)
├── ARCHITECTURE.md
├── IA_EVIDENCE.md    # Evidencia de prompts con IA
└── docker-compose.yml  # (fase 5)
```

## Inicio rápido

### API local (Fase 2)

```powershell
cd backend
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

Documentación interactiva: [http://localhost:8000/docs](http://localhost:8000/docs)

**Probar el endpoint:**

```powershell
# alert: true
curl -X POST http://localhost:8000/webhook `
  -H "Content-Type: application/json" `
  -d '{"user":"ana","message":"Necesito ayuda urgente"}'

# alert: false
curl -X POST http://localhost:8000/webhook `
  -H "Content-Type: application/json" `
  -d '{"user":"ana","message":"Todo funciona bien"}'
```

| Fase | Comando / acción |
|------|------------------|
| API local | Ver arriba |
| Docker Compose (API + n8n) | _Pendiente — Fase 5_ |
| Cypress | _Pendiente — Fase 7_ |
| URL pública AWS | _Pendiente — Fase 8_ |

## Entregables de la prueba técnica

- [ ] Repositorio público con API, Docker, Cypress y `n8n/*.json`
- [ ] URL de la API en AWS
- [ ] README con instrucciones locales y Cypress
- [ ] Evidencia de IA (`IA_EVIDENCE.md`)

## Licencia

Proyecto de evaluación técnica — uso educativo/demostración.
