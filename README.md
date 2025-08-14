# n8n.io
# n8n on Fly.io (GDL, 1GB RAM, Git Sync)

Este proyecto despliega n8n en Fly.io (región GDL, 1GB RAM) con sincronización automática bilateral de workflows y base de datos usando GitHub y Fly Postgres (plan gratuito).

## Características

- Despliegue de n8n en Fly.io (región GDL, 1GB RAM)
- Arranque y parada automática de la máquina (wake on traffic)
- Exportación y sincronización bidireccional de workflows con GitHub
- Sincronización de base de datos externa (Fly Postgres gratuito)
- Auto deploy desde GitHub Actions (push a main)
- Webhook de auto-despliegue
- Scripts para inicializar DB y autodeploy

## Uso rápido

1. **Clona este repo y configura tus secrets de Fly y GitHub.**
2. **Ajusta `fly.toml` y variables de entorno a tus necesidades.**
3. **Crea el volumen en Fly.io:**  
   `flyctl volumes create n8n_data --region gdl --size 1`
4. **Crea la base de datos gratuita en Fly.io:**  
   `fly pg create --name n8n-db --region gdl --vm-size shared-cpu-1x --initial-cluster-size 1`
5. **Obtén las credenciales de la base:**  
   `fly pg credentials -a n8n-db`
6. **Despliega:**  
   `flyctl launch`
7. **(Opcional) Configura el webhook de GitHub a tu endpoint /scripts/webhook-deploy.sh**

### Sincronización bilateral

- Los scripts `export-workflows.sh` y `import-workflows.sh` permiten exportar e importar workflows de forma automática entre n8n y GitHub.
- El workflow de GitHub Actions `.github/workflows/sync-bilateral.yml` automatiza el proceso cada push y cada hora.

### Seguridad

- Cambia las contraseñas por defecto.
- Usa secrets para credenciales sensibles.

## Licencia

MIT