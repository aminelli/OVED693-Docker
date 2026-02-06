FROM python:3.11-slim

# Metadata
LABEL maintainer="ops@example.com"
LABEL description="Container per backup database - CronJob Kubernetes"

# Installa dipendenze di sistema
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Crea directory di lavoro
WORKDIR /app

# Copia lo script di backup
COPY backup.py /app/backup.py

# Rendi eseguibile lo script
RUN chmod +x /app/backup.py

# Crea directory per i backup
RUN mkdir -p /backups

# Utente non privilegiato
RUN useradd -m -u 1000 backup-user && \
    chown -R backup-user:backup-user /app /backups

USER backup-user

# Comando di default
CMD ["python", "/app/backup.py"]
