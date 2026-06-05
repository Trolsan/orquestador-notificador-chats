# Docker Compose — API + n8n (Fase 5)

Levanta el stack completo local con un solo comando.

## Requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado y en ejecución.

## Levantar el stack

Desde la raíz del proyecto:

```powershell
docker compose up --build -d
```

| Servicio | URL | Descripción |
|----------|-----|-------------|
| API | http://localhost:8000 | FastAPI `POST /webhook` |
| API docs | http://localhost:8000/docs | Swagger UI |
| n8n | http://localhost:5678 | Editor de workflows |

## Verificar estado

```powershell
docker compose ps
docker compose logs api --tail 20
docker compose logs n8n --tail 20
```

## Probar la API (host → contenedor)

```powershell
.\scripts\test-api-local.ps1
```

## Probar n8n → API (Fase 6)

Dentro del contenedor n8n, la API **no** es `localhost:8000`. Usa el nombre del servicio Docker:

```text
http://api:8000/webhook
```

En el nodo **HTTP Request** de n8n:

| Campo | Valor |
|-------|-------|
| Method | POST |
| URL | `http://api:8000/webhook` |
| Body Content Type | JSON |
| Body | `{"user": "nombre", "message": "texto del mensaje"}` |

## Detener

```powershell
docker compose down
```

Para eliminar también el volumen de n8n (workflows guardados):

```powershell
docker compose down -v
```

## Red interna

```text
orquestador-n8n  --POST http://api:8000/webhook-->  orquestador-api
     :5678                                              :8000 (publicado en host)
```

Ambos servicios comparten la red por defecto de Compose. El hostname `api` resuelve al contenedor de la API.

## Errores comunes

| Error | Causa | Solución |
|-------|--------|----------|
| `connection refused` desde n8n | URL `localhost:8000` dentro de n8n | Usar `http://api:8000/webhook` |
| Puerto 8000/5678 ocupado | Otro proceso o contenedor | `docker compose down` o cambiar puertos en `.env` |
| n8n no arranca | API unhealthy | `docker compose logs api` |
| `docker compose` no existe | Docker antiguo | Usar `docker-compose up` o actualizar Docker Desktop |
