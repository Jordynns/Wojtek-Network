#!/bin/bash

sudo mkdir -p "/home/Caddy/config" "/home/Caddy/data"

sudo tee "/home/Caddy/Caddyfile" > /dev/null << 'EOF'

# Reverse proxy for Cockpit
cockpit.local {
    reverse_proxy 192.168.10.3:9090
}

# Reverse proxy for Pi-hole
pihole.local {
    reverse_proxy 192.168.10.2:80
}

# Reverse proxy for Portainer
portainer.local {
    reverse_proxy 192.168.10.3:9443
}



EOF

echo "======================="
echo "=== Caddy Setup ==="
echo "✅ Created Caddy directories"
echo "✅ HTTPS enabled (internal CA)"
echo "✅ Reverse proxies configured"
echo "🔒 Access via https://*.home"
echo "======================="

rm -- "$0"
