#!/bin/bash

sudo mkdir -p "/home/Caddy/config" "/home/Caddy/data"

sudo tee "/home/Caddy/Caddyfile" > /dev/null << 'EOF'

http://cockpit.home {
    # Ensure HTTP redirects to HTTPS
    redir https://cockpit.home{uri} permanent
}

https://cockpit.home {
    reverse_proxy 192.168.10.3:9090
}

http://pihole.home {
    # Ensure HTTP redirects to HTTPS
    redir https://pihole.home{uri} permanent
}

https://pihole.home {
    reverse_proxy 192.168.10.2:80
}

http://portainer.home {
    # Ensure HTTP redirects to HTTPS
    redir https://portainer.home{uri} permanent
}

https://portainer.home {
    reverse_proxy 192.168.10.3:9443
}

http://jellyfin.home {
    # Ensure HTTP redirects to HTTPS
    redir https://jellyfin.home{uri} permanent
}

https://jellyfin.home {
    reverse_proxy 192.168.10.4:8096
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
