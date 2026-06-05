# Despliegue en AWS (App Runner)

_Guía detallada en **Fase 8**._

## Objetivo

Desplegar **únicamente la API** FastAPI con URL pública HTTPS. n8n permanece en local.

## Servicio previsto

- **AWS App Runner** con imagen en **Amazon ECR**
- Misma imagen construida con el `Dockerfile` del directorio `backend/`

## Checklist (pendiente)

- [ ] Build y push de imagen a ECR
- [ ] Servicio App Runner con puerto del contenedor
- [ ] Probar `POST /webhook` con curl desde Internet
- [ ] Registrar URL pública en README
