#!/bin/sh
### Latest Approved Mosquitto Instance

# ---- Mosquitto Instance ----
FROM eclipse-mosquitto:latest AS mosquitto

#RUN mkdir -p /run/secrets/
RUN --mount=type=secret,id=MTC_PASSWD,target=/run/secrets/MTC_PASSWD mosquitto_passwd -c -b /mosquitto/data/passwd "mtconnect" "$(cat /run/secrets/MTC_PASSWD)"

VOLUME ["/mosquitto/data", "/mosquitto/log"]
EXPOSE 1883
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]

### EOF
