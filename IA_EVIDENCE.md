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
