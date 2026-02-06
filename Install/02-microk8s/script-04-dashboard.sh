#!/bin/bash

# Disabilita l'addon (se parzialmente installato)
microk8s disable dashboard

# Installa direttamente con i manifest YAML
microk8s kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

# Verifica che i pod siano in esecuzione
microk8s kubectl get pods -n kubernetes-dashboard


# Crea ServiceAccount e permessi
cat <<EOF | microk8s kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

microk8s kubectl -n kubernetes-dashboard create token admin-user

# microk8s kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard 10443:443

# Poi apri: https://localhost:10443


microk8s kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard -p '{"spec":{"type":"NodePort"}}'

# Ottenere la porta assegnata
microk8s kubectl get svc kubernetes-dashboard -n kubernetes-dashboard