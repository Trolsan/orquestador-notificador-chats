# Docker — API (Fase 4)

## Build

Desde el directorio `backend/` (contexto de build):

```powershell
cd backend
docker build -t orquestador-api .
```

## Run

```powershell
docker run --rm -p 8000:8000 --name orquestador-api orquestador-api
```

La API queda en `http://localhost:8000`.

## Probar

```powershell
curl http://localhost:8000/health
curl -X POST http://localhost:8000/webhook -H "Content-Type: application/json" -d "{\"user\":\"ana\",\"message\":\"Necesito ayuda\"}"
```

O desde la raíz:

```powershell
.\scripts\test-api-local.ps1
```

## Detalles del Dockerfile

| Decisión | Valor | Motivo |
|----------|-------|--------|
| Imagen base | `python:3.12-slim` | Ligera, estable, wheels precompilados |
| Puerto | `8000` | Estándar del proyecto y Compose |
| CMD | `uvicorn` sin `--reload` | Producción / contenedor |
| Contexto | `backend/` | Solo código y deps de la API |

## Errores comunes

| Error | Solución |
|-------|----------|
| `docker: command not found` | Instalar [Docker Desktop](https://www.docker.com/products/docker-desktop/) |
| Puerto 8000 ocupado | Parar uvicorn local o usar `-p 8001:8000` |
| Build lento la primera vez | Normal; pip descarga dependencias |
