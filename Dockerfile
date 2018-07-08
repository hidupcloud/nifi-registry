FROM alpine
LABEL maintainer="Juan Bautista Mesa Roldán <juan.mesa@hidup.io>"

ENV DIST_MIRROR http://archive.apache.org/dist/nifi/nifi-registry
ENV VERSION 0.2.0

ENV NIFI_REGISTRY_HOME /opt/nifi-registry
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

RUN apk add --no-cache tzdata bash curl openjdk8

RUN mkdir -p ${NIFI_REGISTRY_HOME}
RUN curl ${DIST_MIRROR}/nifi-registry-${VERSION}/nifi-registry-${VERSION}-bin.tar.gz > /tmp/nifi-registry-${VERSION}-bin.tar.gz

COPY       deploy/start.sh /
RUN        chmod +x /start.sh

EXPOSE     18080
WORKDIR    ${NIFI_REGISTRY_HOME}
ENTRYPOINT ["/start.sh"]
