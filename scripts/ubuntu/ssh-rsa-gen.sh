#!/usr/bin/env bash
set -e  # exit on any error

echo "=== RSA SSH Key Generator ==="

# Ask for a custom path or use the default
read -rp "Enter key path (default: ~/.ssh/id_rsa): " KEY_PATH
KEY_PATH=${KEY_PATH:-~/.ssh/id_rsa}

# Expand ~ manually (bash doesn't expand inside quotes)
KEY_PATH="${KEY_PATH/#\~/$HOME}"

# Ensure the .ssh directory exists
mkdir -p "$(dirname "$KEY_PATH")"

# Ask for an optional comment
read -rp "Enter key comment (default: Ubuntu SSH RSA Key): " KEY_COMMENT
KEY_COMMENT=${KEY_COMMENT:-Ubuntu SSH RSA Key}

# Generate the RSA key pair
echo "Generating RSA key at: $KEY_PATH"
ssh-keygen -t rsa -b 4096 -C "$KEY_COMMENT" -f "$KEY_PATH"

echo "✅ Done!"
echo "Private key: $KEY_PATH"
echo "Public key:  ${KEY_PATH}.pub"
