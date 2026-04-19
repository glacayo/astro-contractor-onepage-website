#!/bin/bash

# predeploy.sh — Pre-deployment verification
# Run before every git push to main
# Usage: bash scripts/predeploy.sh

set -e  # Stop on any error

echo ""
echo "🔍 Running pre-deploy checks..."
echo ""

# 1. Production build — if this fails, DO NOT push
echo "🔨 Building for production..."
npm run build

echo ""
echo "✅ Build passed! No errors."
echo ""
echo "🌐 Starting preview server for final visual check..."
echo "   Preview: http://localhost:4321"
echo ""
echo "   Review the site, then:"
echo "   → git add . && git commit -m 'your message' && git push origin main"
echo "   → Go to Netlify, create new project, select repo, wait for deploy URL"
echo ""

# 2. Preview in background — visual review before pushing
npm run preview &
