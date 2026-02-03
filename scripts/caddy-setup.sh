#!/bin/bash

BASE_DIR="/home/Caddy"

mkdir -p "$BASE_DIR/config" "$BASE_DIR/data"

cat << 'EOF' > "$BASE_DIR/Caddyfile"
http://pihole.home {
    redir / /admin{uri}
    reverse_proxy 192.168.10.2:80
}

http://portainer.home {
    reverse_proxy 192.168.10.3:9443
}
EOF

echo "Caddy directory structure and Caddyfile created successfully."
