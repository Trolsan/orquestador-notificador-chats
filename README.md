# Orquestador Notificador de Chats

Prueba de concepto (PoC) para un servicio que procesa mensajes simulados, evalúa si requieren atención inmediata y expone una API desplegable en AWS. Incluye orquestación con **n8n**, contenedorización con **Docker**, pruebas con **Cypress** y evidencia de uso de **IA**.

> **Estado del proyecto:** Fase 6 completada (workflows n8n exportados). Pendiente: Cypress y AWS.

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
| Python 3.11–3.12 (recomendado) | API FastAPI local; Docker usa 3.12 |
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
└── docker-compose.yml
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

**Probar con script automatizado (Fase 3):**

```powershell
# Con la API corriendo en otra terminal
.\scripts\test-api-local.ps1
```

Checklist y casos manuales: [docs/manual-testing.md](./docs/manual-testing.md).

### API con Docker (Fase 4)

```powershell
cd backend
docker build -t orquestador-api .
docker run --rm -p 8000:8000 orquestador-api
```

Probar de nuevo:

```powershell
cd ..
.\scripts\test-api-local.ps1
```

### Docker Compose — API + n8n (Fase 5)

```powershell
# Desde la raíz del proyecto
docker compose up --build -d
```

| Servicio | URL |
|----------|-----|
| API | http://localhost:8000 |
| n8n | http://localhost:5678 |

Probar API desde el host:

```powershell
.\scripts\test-api-local.ps1
```

### Workflow n8n (Fase 6)

```powershell
# 1. Levantar stack
docker compose up -d

# 2. Importar en http://localhost:5678
#    Archivo: n8n/workflow-orquestador.json

# 3. Execute workflow en n8n (Manual Trigger)
#    o probar webhook:
.\scripts\test-n8n-webhook.ps1
```

Guías: [docs/n8n-workflow.md](./docs/n8n-workflow.md) · [docs/docker-compose.md](./docs/docker-compose.md).

| Fase | Comando / acción |
|------|------------------|
| API local | Ver arriba |
| Docker (solo API) | `docker build` + `docker run` en `backend/` |
| Docker Compose (API + n8n) | `docker compose up --build -d` |
| Workflow n8n | Importar `n8n/workflow-orquestador.json` |
| Cypress | _Pendiente — Fase 7_ |
| URL pública AWS | _Pendiente — Fase 8_ |

## Entregables de la prueba técnica

- [ ] Repositorio público con API, Docker, Cypress y `n8n/*.json`
- [ ] URL de la API en AWS
- [ ] README con instrucciones locales y Cypress
- [ ] Evidencia de IA (`IA_EVIDENCE.md`)

## Licencia

Proyecto de evaluación técnica — uso educativo/demostración.
