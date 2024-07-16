#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Replace Android API key
sed -i '' "s/GOOGLE_MAPS_API_upark/$GOOGLE_MAPS_API_KEY/" android/app/src/main/res/values/strings.xml

# Replace iOS API key
sed -i '' "s/GOOGLE_MAPS_API_upark/$GOOGLE_MAPS_API_KEY/" ios/Runner/AppDelegate.swift