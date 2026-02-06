#!/bin/bash
# Script per il deployment completo del CronJob su Kubernetes

set -e

echo "🚀 Deployment CronJob Kubernetes"
echo "================================"

# Colori per output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Namespace (modifica se necessario)
NAMESPACE="default"

# Step 1: Build Docker image
echo -e "\n${YELLOW}Step 1: Build Docker image${NC}"
docker build -t backup-app:1.0 .
echo -e "${GREEN}✓ Immagine Docker creata${NC}"

# Step 2: Deploy PVC
echo -e "\n${YELLOW}Step 2: Deploy Persistent Volume Claim${NC}"
kubectl apply -f pvc.yaml -n $NAMESPACE
echo -e "${GREEN}✓ PVC creato${NC}"

# Step 3: Deploy ConfigMap
echo -e "\n${YELLOW}Step 3: Deploy ConfigMap${NC}"
kubectl apply -f configmap.yaml -n $NAMESPACE
echo -e "${GREEN}✓ ConfigMap creato${NC}"

# Step 4: Deploy Secret
echo -e "\n${YELLOW}Step 4: Deploy Secret${NC}"
kubectl apply -f secret.yaml -n $NAMESPACE
echo -e "${GREEN}✓ Secret creato${NC}"

# Step 5: Deploy CronJob
echo -e "\n${YELLOW}Step 5: Deploy CronJob${NC}"
kubectl apply -f cronjob.yaml -n $NAMESPACE
echo -e "${GREEN}✓ CronJob creato${NC}"

# Verifica deployment
echo -e "\n${YELLOW}Verifica deployment:${NC}"
kubectl get cronjob -n $NAMESPACE
kubectl get pvc -n $NAMESPACE

echo -e "\n${GREEN}✓ Deployment completato con successo!${NC}"
echo -e "\nPer testare manualmente il job esegui:"
echo -e "  kubectl create job backup-test --from=cronjob/backup-database-cronjob -n $NAMESPACE"
