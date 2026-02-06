# Usa l'immagine ufficiale Node.js come base
FROM node:18-alpine

# Imposta la directory di lavoro nel container
WORKDIR /app

# Copia i file di dipendenze
COPY package*.json ./

# Installa le dipendenze di produzione
RUN npm install --only=production

# Copia il resto dell'applicazione
COPY . .

# Espone la porta su cui l'app sarà in ascolto
EXPOSE 3000

# Definisce la variabile d'ambiente per la modalità produzione
ENV NODE_ENV=production

# Comando per avviare l'applicazione
CMD ["npm", "start"]
