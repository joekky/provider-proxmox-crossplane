#!/bin/bash
set -euo pipefail

# Validate Crossplane Package
validate_package() {
    local package_path=$1

    # Check package file exists
    if [ ! -f "$package_path" ]; then
        echo "❌ Package file does not exist: $package_path"
        exit 1
    }

    # Optional: Add crossplane package validation
    crossplane xpkg validate "$package_path" || {
        echo "❌ Invalid Crossplane package"
        exit 1
    }

    echo "✅ Package validated successfully: $package_path"
}

main() {
    local package_dir=${1:-"package/_output"}
    
    echo "🔍 Scanning package directory: $package_dir"
    
    # Find all .xpkg files
    packages=$(find "$package_dir" -name "*.xpkg")
    
    if [ -z "$packages" ]; then
        echo "❌ No package files found"
        exit 1
    fi

    for pkg in $packages; do
        validate_package "$pkg"
    done
}

main "$@"