#!/bin/bash

# setup.sh — New project bootstrap
# Run once when starting a new contractor one-page website project
# Usage: bash scripts/setup.sh

set -e  # Stop on any error

echo ""
echo "🚀 Setting up contractor one-page website..."
echo ""

# 1. Install dependencies
echo "📦 Installing dependencies..."
npm install
echo ""

# 2. Process client photos
echo "📸 Processing COMPANY-PHOTOS..."
node scripts/process-images.mjs
echo ""

# 3. Generate favicon from logo
echo "🖼️  Generating favicon..."
node scripts/generate-favicon.mjs
echo ""

echo "✅ Setup complete! Starting dev server..."
echo ""
echo "   Local: http://localhost:4321"
echo ""

# 4. Start dev server in background so the terminal stays free
npm run dev &
