#!/bin/bash

# Extract version number from pubspec.yaml
version=$(cat pubspec.yaml | grep "version" | awk '{print $2}' | tr -d "'" | tr -d '"')

version_file=assets/VERSION

rm $version_file

echo $version >> $version_file
echo "Updated version to $version"