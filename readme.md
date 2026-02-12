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
