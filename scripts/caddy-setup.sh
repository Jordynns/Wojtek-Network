#!/bin/bash

sudo mkdir -p "/home/Caddy/config" "/home/Caddy/data"

sudo cat << 'EOF' > "/home/Caddy/Caddyfile"
http://pihole.home {
    redir / /admin{uri}
    reverse_proxy 192.168.10.2:80
}

http://portainer.home {
    reverse_proxy 192.168.10.3:9443
}

http://jellyfin.home {
    reverse_proxy 192.168.10.4:8096
}

http://cockpit.home {
    reverse_proxy 192.168.10.20:9090
}
EOF

echo "=== Caddy Setup ==="
echo "✅ Created Caddy Directory"
echo "✅ Created Caddyfile"
echo "✅ Writing reverse proxies"
echo "✅ Finished Caddy setup"
echo "======================="

rm -- "$0"
