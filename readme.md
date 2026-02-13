=======================================================================
🌐 Docker Cloudflare DDNS
=======================================================================
A lightweight Docker-based Dynamic DNS (DDNS) solution using Cloudflare.
This service automatically updates a Cloudflare DNS A record whenever your public IP address changes.

🚀 Why This Exists
Many home labs and self-hosted environments:
    • Sit behind residential ISPs
    • Receive dynamic (changing) public IP addresses
    • Need a stable domain name for remote access
This container solves that by:
    • Detecting the current public IP
    • Updating Cloudflare DNS automatically
    • Keeping your domain pointing to the correct IP

🧠 Mental Model
    DDNS is the map.
    It tells the internet where your network lives.
It does not:
    • Expose services
    • Handle routing
    • Open firewall ports
It only updates DNS records.

🏗️ Requirements
    • Docker Engine
    • A Cloudflare account
    • A registered domain managed in Cloudflare

🔑 Cloudflare API Token Setup
Create a Custom API Token in Cloudflare:
Permissions
    • Zone → DNS → Edit
Zone Resources
    • Include → Specific zone → yourdomain.com
Do not use the Global API Key.

📝 Summary
This setup provides:
    • Stable domain name
    • Automatic IP updates
    • Zero manual DNS maintenance
    • Minimal resource usage
    • Simple deployment
    
It is ideal for:
    • Home labs
    • Self-hosted services
    • Remote access setups
    • Small-scale infrastructure

📜 Logging
This container logs to:
    • Docker stdout (visible in docker logs)
    • /logs/ddns.log (if volume is mounted)
This means:
    • You can monitor it via Portainer
    • Logs persist across container restarts (if volume mounted)
🔄 How It Works Internally
Every 5 minutes:
    1. Fetch public IP via ipify
    2. Retrieve Zone ID from Cloudflare
    3. Retrieve DNS record ID
    4. Compare stored IP vs detected IP
    5. Update only if changed
No unnecessary API calls.
No constant rewrites.
Minimal noise.

🧩 Why Build Custom Instead of Using a Public Image?
Pros of Custom Build
    • Full control
    • No dependency on external maintainers
    • No surprise breaking changes
    • Easier debugging
    • Transparent logic
    • Minimal attack surface
Cons
    • You maintain it
    • You must monitor API changes
    • No automatic feature updates
If you want maximum stability and clarity, custom wins.
If you want convenience and community maintenance, prebuilt images are fine — until they break unexpectedly.

🛠️ Use Cases
Ideal for:
    • Home labs
    • Reverse proxy setups
    • Self-hosted apps
    • VPN endpoints
    • Remote SSH access
    • Small infrastructure environments

📝 Summary
This setup provides:
    • Stable domain name
    • Automatic IP updates
    • Zero manual DNS maintenance
    • Lightweight resource usage
    • Transparent logic
    • Simple deployment
