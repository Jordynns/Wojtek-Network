#!/bin/bash

sudo mkdir -p "/home/Caddy/config" "/home/Caddy/data"

sudo tee "/home/Caddy/Caddyfile" > /dev/null << 'EOF'

pihole.home {
    tls internal
    redir / /admin{uri}
    reverse_proxy http://192.168.10.2:80
}

portainer.home {
    tls internal
    reverse_proxy https://192.168.10.3:9443 {
        transport http {
            tls_insecure_skip_verify
        }
    }
}

cockpit.home {
    tls internal
    reverse_proxy http://192.168.10.3:9090
}

jellyfin.home {
    tls internal
    reverse_proxy http://192.168.10.4:8096
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
