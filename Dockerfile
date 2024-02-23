#!/bin/sh
### Latest Approved Mosquitto Instance

# ---- Mosquitto Instance ----
FROM eclipse-mosquitto:latest AS mosquitto

# RUN --mount=type=secret,id=mtc_password mosquitto_passwd -c -b /mosquitto/data/passwd mtconnect $(cat /run/secrets/mtc_password)
RUN --mount=type=secret,id=MTC_PASSWD,target=/run/secrets/MTC_PASSWD \
    --mount=type=secret,id=MTC_USERNAME,target=/run/secrets/MTC_USERNAME \
    mosquitto_passwd -c -b /mosquitto/data/passwd "$(cat /run/secrets/MTC_USERNAME)" "$(cat /run/secrets/MTC_PASSWD)"

RUN --mount=type=secret,id=ODS_PASSWD,target=/run/secrets/ODS_PASSWD \
    --mount=type=secret,id=ODS_USERNAME,target=/run/secrets/ODS_USERNAME \
    mosquitto_passwd -b /mosquitto/data/passwd "$(cat /run/secrets/ODS_USERNAME)" "$(cat /run/secrets/ODS_PASSWD)"


VOLUME ["/mosquitto/data", "/mosquitto/log"]
EXPOSE 1883
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]

### EOF
