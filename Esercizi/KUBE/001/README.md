# CronJob Kubernetes - Esempio Completo

Questo progetto dimostra come creare e gestire un CronJob in Kubernetes per eseguire backup automatici di un database.

## 📋 Struttura del Progetto

```
.
├── cronjob.yaml      # Definizione del CronJob Kubernetes
├── configmap.yaml    # Configurazione non sensibile
├── secret.yaml       # Credenziali database
├── pvc.yaml          # Persistent Volume Claim per i backup
├── Dockerfile        # Immagine container per il job
├── backup.py         # Script Python per il backup
└── README.md         # Questa documentazione
```

## 🎯 Caratteristiche del CronJob

- **Schedule**: Esegue ogni giorno alle 2:00 AM
- **Concurrency Policy**: `Forbid` (non permette esecuzioni concorrenti)
- **History Limits**: Mantiene 3 job riusciti e 1 fallito
- **Backoff Limit**: 2 tentativi in caso di fallimento
- **Timeout**: 600 secondi (10 minuti)
- **Resources**: Limiti di CPU e memoria configurati

## 🚀 Deployment

### 1. Build dell'immagine Docker

```bash
# Build dell'immagine
docker build -t backup-app:1.0 .

# (Opzionale) Push su registry
docker tag backup-app:1.0 your-registry/backup-app:1.0
docker push your-registry/backup-app:1.0
```

### 2. Deploy su Kubernetes

```bash
# Crea il namespace (opzionale)
kubectl create namespace backup-system

# Deploy nell'ordine corretto
kubectl apply -f pvc.yaml
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f cronjob.yaml
```

### 3. Verifica del deployment

```bash
# Verifica il CronJob
kubectl get cronjobs

# Visualizza dettagli del CronJob
kubectl describe cronjob backup-database-cronjob

# Lista i job creati dal CronJob
kubectl get jobs

# Visualizza i pod dei job
kubectl get pods --selector=app=backup-job
```

## 🔧 Gestione del CronJob

### Trigger manuale del job

```bash
# Crea un job one-time dal CronJob
kubectl create job backup-manual --from=cronjob/backup-database-cronjob
```

### Visualizza i log

```bash
# Lista i pod recenti
kubectl get pods --sort-by=.metadata.creationTimestamp

# Visualizza log del pod più recente
kubectl logs <pod-name>

# Segui i log in tempo reale
kubectl logs -f <pod-name>
```

### Sospendi/Riattiva il CronJob

```bash
# Sospendi l'esecuzione
kubectl patch cronjob backup-database-cronjob -p '{"spec":{"suspend":true}}'

# Riattiva l'esecuzione
kubectl patch cronjob backup-database-cronjob -p '{"spec":{"suspend":false}}'
```

### Modifica lo schedule

```bash
# Modifica il CronJob
kubectl edit cronjob backup-database-cronjob

# Oppure applica modifiche al file YAML
# Modifica cronjob.yaml e poi:
kubectl apply -f cronjob.yaml
```

## 📅 Formato Cron Schedule

Il formato dello schedule è: `minuto ora giorno mese giorno-settimana`

Esempi comuni:
```
"0 2 * * *"        # Ogni giorno alle 2:00 AM
"*/15 * * * *"     # Ogni 15 minuti
"0 */6 * * *"      # Ogni 6 ore
"0 0 * * 0"        # Ogni domenica a mezzanotte
"30 3 * * 1-5"     # Lun-Ven alle 3:30 AM
"0 0 1 * *"        # Il primo giorno di ogni mese
```

## 🔐 Gestione dei Secret

### Creare secret da file

```bash
kubectl create secret generic db-credentials \
  --from-literal=username=backup_user \
  --from-literal=password=SuperSecretPassword123!
```

### Codifica base64 per i secret

```bash
echo -n 'backup_user' | base64
echo -n 'SuperSecretPassword123!' | base64
```

## 📊 Monitoring e Troubleshooting

### Eventi del CronJob

```bash
kubectl get events --sort-by='.lastTimestamp' | grep backup
```

### Debug di un job fallito

```bash
# Visualizza dettagli del job
kubectl describe job <job-name>

# Visualizza log del pod fallito
kubectl logs <pod-name>

# Ottieni YAML del pod per analisi
kubectl get pod <pod-name> -o yaml
```

### Verifica risorse

```bash
# Verifica PVC
kubectl get pvc backup-pvc
kubectl describe pvc backup-pvc

# Verifica ConfigMap
kubectl get configmap db-config -o yaml

# Verifica Secret
kubectl get secret db-credentials -o yaml
```

## 🧪 Test Locale

### Test dello script Python

```bash
# Imposta variabili d'ambiente
export DB_HOST=localhost
export DB_PORT=5432
export DB_NAME=testdb
export DB_USER=testuser
export DB_PASSWORD=testpass

# Esegui lo script
python backup.py
```

### Test del container Docker

```bash
docker run --rm \
  -e DB_HOST=localhost \
  -e DB_PORT=5432 \
  -e DB_NAME=testdb \
  -e DB_USER=testuser \
  -e DB_PASSWORD=testpass \
  -v $(pwd)/backups:/backups \
  backup-app:1.0
```

## 🔄 Politiche di Concorrenza

- **Allow**: Permette esecuzioni concorrenti
- **Forbid**: Non permette nuove esecuzioni se una è già in corso
- **Replace**: Termina il job corrente e ne avvia uno nuovo

## 📝 Note Importanti

1. **TimeZone**: I CronJob Kubernetes usano il fuso orario UTC
2. **History Limits**: Configurare appropriatamente per evitare accumulo di job vecchi
3. **Resources**: Definire sempre requests e limits per CPU e memoria
4. **Backup dei backup**: Considera una strategia di backup offsite
5. **Monitoring**: Implementa alerting per job falliti

## 🛠️ Personalizzazione

Per adattare questo esempio alle tue esigenze:

1. Modifica `backup.py` con la tua logica di backup
2. Aggiorna le variabili d'ambiente in `cronjob.yaml`
3. Modifica lo schedule secondo le tue necessità
4. Adatta le risorse (CPU/memoria) al carico di lavoro
5. Configura il PVC con la dimensione appropriata

## 📚 Risorse Utili

- [Kubernetes CronJob Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
- [Cron Expression Generator](https://crontab.guru/)
- [Kubernetes Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)

## ⚠️ Cleanup

```bash
# Elimina tutte le risorse
kubectl delete cronjob backup-database-cronjob
kubectl delete pvc backup-pvc
kubectl delete configmap db-config
kubectl delete secret db-credentials

# Elimina i job e pod creati
kubectl delete jobs --selector=app=backup-job
```
