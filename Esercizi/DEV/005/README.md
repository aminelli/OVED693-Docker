# Applicazione Web PHP con Docker 🐳

Una semplice applicazione web PHP containerizzata con Docker.

## Contenuto

- **index.php**: Applicazione web PHP che mostra informazioni sul server e sulla configurazione
- **Dockerfile**: Configurazione per creare l'immagine Docker
- **.dockerignore**: File e directory esclusi dal build context

## Prerequisiti

- Docker installato sul sistema
- Porta 8080 disponibile (o modificare il comando)

## Come usare

### 1. Build dell'immagine Docker

```bash
docker build -t php-webapp .
```

### 2. Eseguire il container

```bash
docker run -d -p 8080:80 --name mia-app-php php-webapp
```

### 3. Accedere all'applicazione

Apri il browser e vai a: http://localhost:8080

### 4. Fermare il container

```bash
docker stop mia-app-php
```

### 5. Rimuovere il container

```bash
docker rm mia-app-php
```

### 6. Rimuovere l'immagine

```bash
docker rmi php-webapp
```

## Comandi utili

### Visualizzare i log del container
```bash
docker logs mia-app-php
```

### Accedere al container in esecuzione
```bash
docker exec -it mia-app-php bash
```

### Visualizzare i container in esecuzione
```bash
docker ps
```

### Visualizzare tutte le immagini
```bash
docker images
```

## Caratteristiche

- PHP 8.2 con Apache
- Estensioni MySQL (mysqli e PDO)
- Interfaccia web responsive
- Informazioni sul server e ambiente
- Pronto per l'uso in sviluppo

## Personalizzazione

Per modificare la porta esposta, cambia il parametro `-p` nel comando docker run:
```bash
docker run -d -p 3000:80 --name mia-app-php php-webapp
```

## Note

L'applicazione è pensata per scopi didattici e di testing. Per un uso in produzione, considera:
- Configurazione di sicurezza avanzata
- Uso di volumi per i dati persistenti
- Configurazione HTTPS
- Variabili d'ambiente per le configurazioni sensibili
