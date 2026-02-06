# Usa l'immagine ufficiale Python come base
FROM python:3.11-slim

# Imposta la directory di lavoro nel container
WORKDIR /app

# Copia il file dei requisiti
COPY requirements.txt .

# Installa le dipendenze
RUN pip install --no-cache-dir -r requirements.txt

# Copia il resto dell'applicazione
COPY app.py .

# Espone la porta su cui l'app sarà in ascolto
EXPOSE 5000

# Definisce le variabili d'ambiente
ENV FLASK_ENV=production
ENV PORT=5000

# Comando per avviare l'applicazione con gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "4", "app:app"]
