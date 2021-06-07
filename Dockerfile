FROM bmoorman/ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

ENV NZBGET_PORT=6789

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
    jq \
    wget \
 && fileUrl=$(curl --silent --location "https://api.github.com/repos/nzbget/nzbget/releases/latest" | jq --raw-output '.assets[] | select(.name | endswith("bin-linux.run")) | .browser_download_url') \
 && wget --quiet --directory-prefix /tmp "${fileUrl}" \
 && sh /tmp/nzbget-*-bin-linux.run --destdir /opt/nzbget \
 && apt-get autoremove --yes --purge \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY nzbget/ /etc/nzbget/

VOLUME /config /data

EXPOSE ${SABNZBD_PORT}

CMD ["/etc/nzbget/start.sh"]

HEALTHCHECK --interval=60s --timeout=5s CMD curl --insecure --silent --show-error --fail "http://localhost:${NZBGET_PORT}/" || exit 1
