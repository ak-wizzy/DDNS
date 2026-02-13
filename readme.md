=======================================================================
🌐 Cloudflare DDNS – Custom Docker Implementation
=======================================================================
Overview
This service maintains a stable DNS A record in Cloudflare for environments with dynamic public IP addresses.
It runs as a lightweight Docker container and automatically updates a specified Cloudflare DNS record when the public IPv4 address changes.
This implementation replaces third-party DDNS images with a custom, minimal Alpine-based container for better transparency, control, and stability.

Purpose
Residential ISPs typically assign dynamic public IP addresses. When the IP changes, external access to home lab services breaks.
This service ensures:
    • The configured Cloudflare A record always reflects the current public IP.
    • No manual DNS updates are required.
    • Infrastructure remains reachable via domain name.

Architecture Context
Mental Model
    • DDNS = The map
    • Reverse proxy = The receptionist
    • Firewall/router = The gate
DDNS only updates DNS records.
It does not expose services or manage routing.

Technical Summary
    • Runs in Docker
    • Polls public IPv4 every 5 minutes
    • Compares against current Cloudflare record
    • Updates record only if IP has changed
    • Uses Cloudflare API Token (scoped permissions)
    • Logs to Docker stdout and persistent log volume

Dependencies
    • Docker Engine
    • Cloudflare-managed domain
    • Scoped Cloudflare API Token (DNS Edit + Zone Read)

Configuration Parameters
Variable	Description
CF_API_TOKEN	Cloudflare API Token
CF_ZONE	Root domain (example.com)
CF_RECORD	Subdomain (e.g., lab)
CF_TTL	DNS TTL (1 = Auto)
CF_PROXY	Cloudflare proxy enabled (true/false)

Logging
Logs are available via:
    • Docker logs
    • Portainer
    • Persistent /logs/ddns.log (if volume mounted)
Logs include timestamps for:
    • Container startup
    • IP detection
    • DNS lookup
    • Record updates
    • Error conditions

Operational Notes
    • Only IPv4 is supported in current build.
    • Poll interval is fixed at 5 minutes.
    • No automatic alerting is implemented.
    • Designed for single A record management.

Known Limitations
    • No IPv6 support
    • No notification integration
    • Relies on Cloudflare API stability
    • Single-record scope

When to Use
Recommended for:
    • Home lab environments
    • Self-hosted applications
    • Reverse proxy deployments
    • Small infrastructure setups

Change History
    • Replaced third-party DDNS image with custom Alpine build
    • Implemented persistent logging
    • Standardized on Cloudflare API Token authentication
