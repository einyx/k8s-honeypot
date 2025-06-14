#!/bin/bash

# T-Pot CE Minikube Setup Script
set -e

echo "🐝 Setting up T-Pot CE on Minikube"

# Check prerequisites
command -v minikube >/dev/null 2>&1 || { echo "❌ minikube is required but not installed. Aborting." >&2; exit 1; }
command -v kubectl >/dev/null 2>&1 || { echo "❌ kubectl is required but not installed. Aborting." >&2; exit 1; }

# Start minikube with sufficient resources
echo "🚀 Starting minikube with T-Pot optimized settings..."
minikube start \
  --cpus=4 \
  --memory=8192 \
  --disk-size=100g \
  --driver=docker \
  --addons=storage-provisioner,default-storageclass,metrics-server

# Enable required addons
echo "🔧 Enabling minikube addons..."
minikube addons enable ingress
minikube addons enable dashboard

# Apply Kubernetes manifests
echo "📦 Deploying T-Pot to Kubernetes..."
kubectl apply -k kubernetes/

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/elasticsearch -n tpot
kubectl wait --for=condition=available --timeout=300s deployment/kibana -n tpot
kubectl wait --for=condition=available --timeout=300s deployment/nginx -n tpot

# Get service URLs
echo "🌐 Getting service URLs..."
TPOT_WEB_URL=$(minikube service tpot-web -n tpot --url)
KIBANA_URL=$(minikube service kibana -n tpot --url)

echo ""
echo "✅ T-Pot CE deployment completed!"
echo ""
echo "🔗 Access URLs:"
echo "   T-Pot Web UI: $TPOT_WEB_URL"
echo "   Kibana:       $KIBANA_URL"
echo ""
echo "📊 Honeypot Services:"
kubectl get services -n tpot -o wide | grep NodePort
echo ""
echo "🎯 To access services from host:"
echo "   minikube service list -n tpot"
echo ""
echo "📝 View logs:"
echo "   kubectl logs -n tpot deployment/cowrie"
echo "   kubectl logs -n tpot deployment/dionaea"
echo ""
echo "🔍 Monitor deployment:"
echo "   kubectl get pods -n tpot -w"
echo ""
echo "🎮 Access Kubernetes dashboard:"
echo "   minikube dashboard"