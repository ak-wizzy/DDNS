FROM alpine:3.20

RUN apk add --no-cache curl jq bash

WORKDIR /app

COPY ddns.sh /app/ddns.sh
RUN chmod +x /app/ddns.sh

CMD ["/app/ddns.sh"]
