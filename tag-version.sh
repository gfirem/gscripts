#!/bin/bash

branchname=$1

if [[ ! -f "readme.txt" ]]; then
    echo "readme.txt file not detected. Are you running this script from your plugin directory?"
    exit 1
fi

version=$(grep "^Stable tag:" readme.txt | awk -F' ' '{print $NF}')

echo "Version: $version"

git checkout ${branchname}
git tag -af ${version} -m "$version"
git push origin "New version: $version"
echo "Created the git tag for $version version"