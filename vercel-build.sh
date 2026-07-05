#!/bin/bash

# Exit on error
set -e

echo "=== Starting Flutter Web Build on Vercel ==="

# Clone Flutter stable branch if it doesn't exist
if [ ! -d "flutter" ]; then
  echo "Cloning Flutter SDK (stable branch)..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable
else
  echo "Flutter SDK already exists. Skipping clone."
fi

# Add Flutter to the PATH
export PATH="$PATH:$(pwd)/flutter/bin"

echo "Checking Flutter version..."
flutter --version

echo "Enabling Web support..."
flutter config --enable-web

echo "Getting pub packages..."
flutter pub get

echo "Building Flutter Web in Release mode..."
flutter build web --release

echo "=== Flutter Web Build Completed Successfully ==="
