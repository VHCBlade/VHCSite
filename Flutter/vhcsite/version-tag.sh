#!/bin/bash

# Extract version number from pubspec.yaml
version=$(cat pubspec.yaml | grep "version" | awk '{print $2}' | tr -d "'" | tr -d '"')

# Create and push git tag
# git tag -a "v$version" -m "Version $version"
# git push origin "v$version"
echo $version
