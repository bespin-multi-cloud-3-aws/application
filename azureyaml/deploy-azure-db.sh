#!/bin/bash
set -e

echo "Fetching secrets from Key Vault (db-certifi)..."
export DB_PASSWORD_AZURE=$(az keyvault secret show --vault-name db-certifi --name db-password --query value -o tsv)
export GROQ_API_KEY=$(az keyvault secret show --vault-name db-certifi --name groq-api-key --query value -o tsv)

echo "Applying db-azure.yaml..."
envsubst < db-azure.yaml | kubectl apply -f -

echo "Done. Verifying secret..."
kubectl get secret db-secret -n petclinic
kubectl get secret ai-secret -n petclinic