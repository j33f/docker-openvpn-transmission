FROM alpine:latest
ENV LABEL_MAINTAINER="Jean-François Vial <jeff@modulaweb.fr>" \
    LABEL_IMAGE_NAME="j33f/transmission-openvpn" \
    LABEL_URL="https://hub.docker.com/r/j33f/transmission-openvpn/" \
    LABEL_VCS_URL="https://github.com/j33f/docker-transmission-openvpn" \
    LABEL_DESCRIPTION="Transmission daemon over openvpn (to use with .ovpn files containing certificates)" \
    LABEL_LICENSE="apache-2.0"

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

ARG LABEL_VERSION="latest"
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF

# Build-time metadata as defined at http://label-schema.org
LABEL maintainer=$LABEL_MAINTAINER \
      org.label-schema.build-date=$LABEL_BUILD_DATE \
      org.label-schema.description=$LABEL_DESCRIPTION \
      org.label-schema.name=$LABEL_IMAGE_NAME \
      org.label-schema.schema-version="1.0" \
      org.label-schema.url=$LABEL_URL \
      org.label-schema.license=$LABEL_LICENSE \
      org.label-schema.vcs-ref=$LABEL_VCS_REF \
      org.label-schema.vcs-url=$LABEL_VCS_URL \
      org.label-schema.version=$LABEL_VERSION