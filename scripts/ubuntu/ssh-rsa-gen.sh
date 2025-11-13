#!/bin/bash
set -e 

echo "=== RSA SSH Key Generator ==="

read -rp "Enter a name or full path for your key (default: ~/.ssh/id_rsa): " KEY_PATH
KEY_PATH=${KEY_PATH:-~/.ssh/id_rsa}

KEY_PATH=$(eval echo "$KEY_PATH")

read -rp "Enter a comment for your key (default: Ubuntu SSH RSA Key): " KEY_COMMENT
KEY_COMMENT=${KEY_COMMENT:-Ubuntu SSH RSA Key}

echo "Generating RSA key at: $KEY_PATH"
ssh-keygen -t rsa -b 4096 -C "$KEY_COMMENT" -f "$KEY_PATH"

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    echo "Starting ssh-agent..."
    eval "$(ssh-agent -s)"
fi

ssh-add "$KEY_PATH"

read -rp "Enter remote username: " REMOTE_USER
read -rp "Enter remote host (IP or domain): " REMOTE_HOST

echo "Copying key to $REMOTE_USER@$REMOTE_HOST..."
ssh-copy-id -i "${KEY_PATH}.pub" "$REMOTE_USER@$REMOTE_HOST"

echo "✅ All done!"
echo "You can now connect using:"
echo "ssh -i $KEY_PATH $REMOTE_USER@$REMOTE_HOST"
