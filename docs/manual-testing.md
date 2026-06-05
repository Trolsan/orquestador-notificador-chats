# Pruebas manuales locales — Fase 3

Checklist para validar `POST /webhook` antes de Docker Compose y Cypress.

## Pre-requisitos

- API corriendo en `http://localhost:8000`
- `curl` o Postman

## Casos de prueba

| # | Mensaje | `alert` esperado | Palabra clave |
|---|---------|------------------|---------------|
| 1 | `Necesito ayuda urgente` | `true` | urgente + ayuda |
| 2 | `ERROR en el servidor` | `true` | error (mayúsculas) |
| 3 | `Por favor, necesito ayuda` | `true` | ayuda |
| 4 | `Todo funciona correctamente` | `false` | ninguna |
| 5 | `Hola, buenos días` | `false` | ninguna |

## Comandos (PowerShell)

```powershell
# Caso 1 — true
curl -X POST http://localhost:8000/webhook -H "Content-Type: application/json" -d "{\"user\":\"ana\",\"message\":\"Necesito ayuda urgente\"}"

# Caso 2 — true
curl -X POST http://localhost:8000/webhook -H "Content-Type: application/json" -d "{\"user\":\"bob\",\"message\":\"ERROR en el servidor\"}"

# Caso 3 — true
curl -X POST http://localhost:8000/webhook -H "Content-Type: application/json" -d "{\"user\":\"carl\",\"message\":\"Por favor, necesito ayuda\"}"

# Caso 4 — false
curl -X POST http://localhost:8000/webhook -H "Content-Type: application/json" -d "{\"user\":\"ana\",\"message\":\"Todo funciona correctamente\"}"

# Caso 5 — false
curl -X POST http://localhost:8000/webhook -H "Content-Type: application/json" -d "{\"user\":\"ana\",\"message\":\"Hola, buenos días\"}"

# Health check
curl http://localhost:8000/health
```

## Validación de errores (opcional)

```powershell
# 422 — body inválido (campo faltante)
curl -X POST http://localhost:8000/webhook -H "Content-Type: application/json" -d "{\"user\":\"ana\"}"
```

## Script automatizado

Desde la raíz del proyecto:

```powershell
.\scripts\test-api-local.ps1
```

## Criterio de aceptación

- Todos los casos 1–5 devuelven HTTP `200` y el JSON `{"alert": true}` o `{"alert": false}` según la tabla.
- Swagger en `/docs` muestra el endpoint y permite probar interactivamente.
