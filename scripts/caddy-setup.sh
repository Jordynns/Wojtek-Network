#!/bin/bash

sudo mkdir -p "/home/Caddy/config" "/home/Caddy/data"

sudo tee "/home/Caddy/Caddyfile" > /dev/null << 'EOF'

# HTTP redirection for cockpit.home to avoid redirect loops
http://cockpit.home {
    # Ensure HTTP redirects to HTTPS
    redir https://cockpit.home{uri} permanent
}

# HTTPS block for cockpit.home with self-signed certificate
https://cockpit.home {
    tls internal
    reverse_proxy 192.168.10.3:9090
}

# HTTP redirection for pihole.home to avoid redirect loops
http://pihole.home {
    # Ensure HTTP redirects to HTTPS
    redir https://pihole.home{uri} permanent
}

# HTTPS block for pihole.home with self-signed certificate
https://pihole.home {
    tls internal
    reverse_proxy 192.168.10.2:80
}

# HTTP redirection for portainer.home to avoid redirect loops
http://portainer.home {
    # Ensure HTTP redirects to HTTPS
    redir https://portainer.home{uri} permanent
}

# HTTPS block for portainer.home with self-signed certificate
https://portainer.home {
    tls internal
    reverse_proxy 192.168.10.3:9443
}

# HTTP redirection for jellyfin.home to avoid redirect loops
http://jellyfin.home {
    # Ensure HTTP redirects to HTTPS
    redir https://jellyfin.home{uri} permanent
}

# HTTPS block for jellyfin.home with self-signed certificate
https://jellyfin.home {
    tls internal
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
