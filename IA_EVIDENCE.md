# Evidencia de uso de Inteligencia Artificial

Registro de prompts y resultados relevantes para la prueba técnica **Asistente de Desarrollo Integrado**.

---

## Entrada 1 — Análisis inicial y arquitectura

| Campo | Detalle |
|-------|---------|
| **Fecha** | 2026-06-04 |
| **Herramienta** | Cursor (Composer) |
| **Objetivo** | Leer el documento oficial de la prueba, extraer requisitos sin asumir extras, proponer arquitectura, estructura y roadmap antes de codificar. |

### Prompt (resumen)

Actuar como arquitecto/backend/DevOps/QA/tech lead; leer `Prueba Técnica - Asistente de Desarrollo Integrado.docx` en OneDrive; generar solo análisis (requisitos, entregables, arquitectura, carpetas, roadmap); stack preferido FastAPI, Docker, n8n, Cypress, App Runner; trabajar por fases sin código hasta aprobación; mantener `IA_EVIDENCE.md`, `ARCHITECTURE.md`, `README.md`.

### Resultado obtenido

- Extracción completa del DOCX (workflow n8n, `POST /webhook`, keywords, Docker, Cypress, AWS solo API, evidencia IA).
- Separación obligatorios vs ideal (`docker-compose`).
- Arquitectura propuesta y roadmap de 10 fases.
- Riesgos: red Docker n8n→API, Cypress vs contenedores, evidencia IA continua.

### Cómo ayudó al proyecto

Evitó implementar requisitos no pedidos, fijó el orden de fases para entregar rápido con calidad y alineó el stack con la sustentación.

---

## Entrada 2 — Fase 1: Bootstrap del repositorio

| Campo | Detalle |
|-------|---------|
| **Fecha** | 2026-06-04 |
| **Herramienta** | Cursor (Composer) |
| **Objetivo** | Crear repositorio, estructura de carpetas, `.gitignore`, `.env.example` y documentación base sin lógica de negocio. |

### Prompt (resumen)

Usuario confirmó roadmap y arquitectura; ejecutar Fase 1: bootstrap en `C:\Users\santi\Projects\orquestador-notificador-chats`.

### Resultado obtenido

- Repositorio git inicializado.
- Estructura de directorios `backend/`, `n8n/`, `cypress/`, `docs/`.
- Archivos de configuración y documentación inicial.

### Cómo ayudó al proyecto

Base versionable y profesional para desarrollo incremental por fases y evidencia de IA desde el inicio.

---

## Entrada 3 — Fase 2: API FastAPI

| Campo | Detalle |
|-------|---------|
| **Fecha** | 2026-06-04 |
| **Herramienta** | Cursor (Composer) |
| **Objetivo** | Implementar `POST /webhook` con evaluación de palabras clave (`urgente`, `error`, `ayuda`) y respuesta `{"alert": bool}`. |

### Prompt (resumen)

Continuar Fase 2: API FastAPI con tipado Pydantic, servicio `alert_evaluator`, configuración por variables de entorno, `requirements.txt` y documentación actualizada.

### Resultado obtenido

- `backend/app/main.py` — aplicación FastAPI con router y `/health`.
- `backend/app/api/routes/webhook.py` — endpoint `POST /webhook`.
- `backend/app/services/alert_evaluator.py` — lógica case-insensitive con `casefold()`.
- `backend/app/core/config.py` — settings desde `.env`.
- `backend/requirements.txt` — dependencias pinneadas.

### Cómo ayudó al proyecto

Generó el núcleo del negocio en minutos, separando ruta HTTP y lógica pura para facilitar pruebas (Cypress) y sustentación técnica.

---

## Entrada 4 — Fases 3 y 4: Pruebas locales y Dockerfile

| Campo | Detalle |
|-------|---------|
| **Fecha** | 2026-06-04 |
| **Herramienta** | Cursor (Composer) |
| **Objetivo** | Validar contrato `POST /webhook` con casos true/false y contenerizar la API con Dockerfile. |

### Prompt (resumen)

Continuar Fase 3 (pruebas manuales curl/script) y Fase 4 (Dockerfile funcional para la API).

### Resultado obtenido

- `scripts/test-api-local.ps1` — 5 casos + health check automatizados.
- `docs/manual-testing.md` — checklist de pruebas manuales.
- `backend/Dockerfile` — imagen `python:3.12-slim`, uvicorn en puerto 8000.
- `backend/.dockerignore` — excluye `.venv`, caches y `.env`.
- Ejecución del script: **5/5 tests PASS** contra API en `localhost:8000`.

### Cómo ayudó al proyecto

Automatizó la validación del contrato antes de Cypress y dejó la misma imagen lista para Compose (Fase 5) y App Runner (Fase 8).

---

## Entrada 5 — Fase 5: Docker Compose (API + n8n)

| Campo | Detalle |
|-------|---------|
| **Fecha** | 2026-06-04 |
| **Herramienta** | Cursor (Composer) |
| **Objetivo** | Levantar API y n8n con un solo comando; red interna con hostname `api`. |

### Prompt (resumen)

Continuar Fase 5: `docker-compose.yml` que levante API + n8n localmente para probar el flujo completo.

### Resultado obtenido

- `docker-compose.yml` con servicios `api` y `n8n`, volumen `n8n_data`, healthcheck y `depends_on`.
- `docs/docker-compose.md` — guía operativa y troubleshooting de red.
- Variables `API_PORT`, `N8N_PORT`, `TZ` en `.env.example`.
- Documentación de URL interna `http://api:8000/webhook` para el workflow n8n.

### Cómo ayudó al proyecto

Unifica el entorno de demo para la sustentación y evita el error más común: usar `localhost` desde dentro del contenedor n8n.

---
