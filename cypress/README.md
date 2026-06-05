# Cypress

En la **Fase 7** se añadirán pruebas con `cy.request` contra `POST /webhook`:

- Mensaje con palabra clave → `{"alert": true}`
- Mensaje sin palabra clave → `{"alert": false}`

La variable `API_BASE_URL` (ver `.env.example`) definirá el host de la API en local.
