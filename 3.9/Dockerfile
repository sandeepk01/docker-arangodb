# This image is synonymous to arangodb/arangodb on dockerhub
FROM node:16-bullseye-slim

ENV ARANGO_VERSION 3.9.2
ENV ARANGO_URL https://download.arangodb.com/arangodb39/DEBIAN/amd64
ENV ARANGO_PACKAGE arangodb3_${ARANGO_VERSION}-1_amd64.deb
ENV ARANGO_PACKAGE_URL ${ARANGO_URL}/${ARANGO_PACKAGE}
ENV ARANGO_SIGNATURE_URL ${ARANGO_PACKAGE_URL}.asc

# Update the dependencies to get the latest and greatest (and safest!) packages.
RUN apt-get update \
    && \
    apt-get install --no-install-recommends -y pwgen binutils wget curl libjemalloc2 ca-certificates \
    && \
    rm -rf /var/lib/apt/lists/*

RUN yarn global add foxx-cli && \
    mkdir /docker-entrypoint-initdb.d && \
    cd /tmp && \
    wget ${ARANGO_SIGNATURE_URL} && \
    wget ${ARANGO_PACKAGE_URL} && \
    ar x ${ARANGO_PACKAGE} data.tar.gz && \
    tar -C / -x -z -f data.tar.gz && \
    sed -ri \
    -e 's!127\.0\.0\.1!0.0.0.0!g' \
    -e 's!^(file\s*=\s*).*!\1 -!' \
    -e 's!^\s*uid\s*=.*!!' \
    /etc/arangodb3/arangod.conf && \
    chgrp -R 0 /var/lib/arangodb3 /var/lib/arangodb3-apps && \
    chmod -R 775 /var/lib/arangodb3 /var/lib/arangodb3-apps && \
    rm -f /usr/bin/foxx && \
    rm -f ${ARANGO_PACKAGE}* data.tar.gz

# Note that Openshift runs containers by default with a random UID and GID 0.
# We need that the database and apps directory are writable for this config.

ENV GLIBCXX_FORCE_NEW=1

# retain the database directory and the Foxx Application directory
VOLUME ["/var/lib/arangodb3", "/var/lib/arangodb3-apps"]

COPY docker-entrypoint.sh /entrypoint.sh
COPY docker-foxx.sh /usr/bin/foxx

ENTRYPOINT ["/entrypoint.sh"]

# standard port
EXPOSE 8529
CMD ["arangod"]