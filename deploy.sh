#!/bin/bash

# Stop script on error, unbound variables, or pipe failures
set -euo pipefail

echo "🚀 Starting Deployment..."

echo "⬇️  Pulling latest changes..."
git pull

echo "🔨 Building containers before restart (minimizing downtime)..."
sudo docker compose build

echo "🔄 Deploying updated containers..."
sudo docker compose up -d --remove-orphans

echo "🧹 Cleaning unused build images..."
sudo docker image prune -f

echo "✅ Deployment complete! Server is running."
