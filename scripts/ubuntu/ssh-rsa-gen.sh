#!/usr/bin/env bash

set -e

echo "=== RSA SSH Key Generator ==="

read -rp "Enter key path (default: ~/.ssh/id_rsa): " KEY_PATH
KEY_PATH=${KEY_PATH:-~/.ssh/id_rsa}

KEY_PATH="${KEY_PATH/#\~/$HOME}"

mkdir -p "$(dirname "$KEY_PATH")"

if [[ -f "$KEY_PATH" || -f "${KEY_PATH}.pub" ]]; then
    echo "⚠️  Key file already exists: $KEY_PATH"
    read -rp "Do you want to overwrite it? (y/N): " CONFIRM
    CONFIRM=${CONFIRM,,}
    if [[ "$CONFIRM" != "y" && "$CONFIRM" != "yes" ]]; then
        echo "❌ Aborted. Existing key not overwritten."
        exit 1
    fi
    echo "Overwriting existing key..."
fi

read -rp "Enter a comment for your key (default: Ubuntu SSH RSA Key): " KEY_COMMENT
KEY_COMMENT=${KEY_COMMENT:-Ubuntu SSH RSA Key}

echo "Generating 4096-bit RSA key at: $KEY_PATH"
ssh-keygen -t rsa -b 4096 -C "$KEY_COMMENT" -f "$KEY_PATH"

echo
echo "✅ RSA key generation complete!"
echo "Private key: $KEY_PATH"
echo "Public key:  ${KEY_PATH}.pub"
echo "Comment:     $KEY_COMMENT"

echo "============================="

rm -- "$0"
