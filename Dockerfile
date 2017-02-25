FROM alpine:latest
LABEL maintainer Jeff <jeff@modulaweb.fr>

ADD start.sh /start.sh
ADD scripts /scripts
ADD settings /settings

RUN apk add --no-cache openvpn transmission-daemon curl \
    && chmod a+x /start.sh \
    && chmod a+x /scripts/*.sh \
    && mkdir -p /storage/downloads \
    && mkdir -p /storage/incomplete \
    && mkdir -p /transmission

CMD /start.sh