#!/bin/sh

set -e

if [[ ! -f "${NIFI_REGISTRY_HOME}/bin/nifi-registry.sh" ]]
then
  echo "Deploying nifi-registry..."
  tar xfz /tmp/nifi-registry-${VERSION}-bin.tar.gz
  mv ${NIFI_REGISTRY_HOME}/nifi-registry-${VERSION}/* ${NIFI_REGISTRY_HOME}
  rm -rf ${NIFI_REGISTRY_HOME}/nifi-registry-${VERSION}
fi

sed -i "s/nifi\.registry\.web\.http\.host=.*/nifi.registry.web.http.host=${HOSTNAME}/g" ${NIFI_REGISTRY_HOME}/conf/nifi-registry.properties

tail -F ${NIFI_REGISTRY_HOME}/logs/nifi-registry-app.log &
${NIFI_REGISTRY_HOME}/bin/nifi-registry.sh run
