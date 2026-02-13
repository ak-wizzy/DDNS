#!/bin/sh

set -e

# --- Logging setup ---
LOG_FILE="/logs/ddns.log"
mkdir -p /logs
exec >> "$LOG_FILE" 2>&1

echo "--------------------------------------------------"
echo "$(date -u) Container started"
echo "$(date -u) Beginning DDNS loop"

CF_API="https://api.cloudflare.com/client/v4"

while true; do
  echo "$(date -u) Checking public IP..."

  PUBLIC_IP=$(curl -s https://api.ipify.org)
  echo "$(date -u) Detected IP: $PUBLIC_IP"

  # Get Zone ID
  ZONE_ID=$(curl -s -X GET "$CF_API/zones?name=${CF_ZONE}" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json" \
    | jq -r '.result[0].id')

  if [ "$ZONE_ID" = "null" ] || [ -z "$ZONE_ID" ]; then
    echo "$(date -u) Error: Unable to get Zone ID"
    sleep 300
    continue
  fi

  # Get DNS record
  RECORD_DATA=$(curl -s -X GET "$CF_API/zones/$ZONE_ID/dns_records?type=A&name=${CF_RECORD}.${CF_ZONE}" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json")

  RECORD_ID=$(echo "$RECORD_DATA" | jq -r '.result[0].id')
  CURRENT_IP=$(echo "$RECORD_DATA" | jq -r '.result[0].content')

  if [ -z "$RECORD_ID" ] || [ "$RECORD_ID" = "null" ]; then
    echo "$(date -u) Error: DNS record not found"
    sleep 300
    continue
  fi

  echo "$(date -u) Cloudflare IP: $CURRENT_IP"

  if [ "$PUBLIC_IP" != "$CURRENT_IP" ]; then
    echo "$(date -u) IP changed. Updating Cloudflare..."

    curl -s -X PUT "$CF_API/zones/$ZONE_ID/dns_records/$RECORD_ID" \
      -H "Authorization: Bearer ${CF_API_TOKEN}" \
      -H "Content-Type: application/json" \
      --data "{\"type\":\"A\",\"name\":\"${CF_RECORD}.${CF_ZONE}\",\"content\":\"${PUBLIC_IP}\",\"ttl\":${CF_TTL},\"proxied\":${CF_PROXY}}"

    echo "$(date -u) Update sent."
  else
    echo "$(date -u) IP unchanged."
  fi

  echo "$(date -u) Sleeping 300 seconds..."
  sleep 300
done
