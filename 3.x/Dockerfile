# This image is synonymous to https://hub.docker.com/r/arangodb/arangodb
ARG NODE_IMAGE

FROM node:$NODE_IMAGE

ARG DB_PACKAGE
ARG DB_PACKAGE_URL
ARG DB_SIGNATURE_URL
ARG PGP_KEY_URL
ARG SIGNATURE_FILE

# Update the dependencies to get the latest and greatest (and safest!) packages.
RUN apt-get update \
    && \
    apt-get install --no-install-recommends -y gnupg pwgen binutils wget libjemalloc2 ca-certificates \
    && \
    rm -rf /var/lib/apt/lists/*

RUN yarn global add foxx-cli && \
    mkdir /docker-entrypoint-initdb.d && \
    cd /tmp && \
    wget -O keyfile.pgp $PGP_KEY_URL && \
    gpg --import keyfile.pgp && \
    wget $DB_SIGNATURE_URL && \
    wget $DB_PACKAGE_URL && \
    gpg --verify $SIGNATURE_FILE && \
    ar x $DB_PACKAGE data.tar.gz && \
    tar -C / -x -z -f data.tar.gz && \
    sed -ri -e 's!127\.0\.0\.1!0.0.0.0!g' -e 's!^(file\s*=\s*).*!\1 -!' -e 's!^\s*uid\s*=.*!!' /etc/arangodb3/arangod.conf && \
    chgrp -R 0 /var/lib/arangodb3 /var/lib/arangodb3-apps && \
    chmod -R 775 /var/lib/arangodb3 /var/lib/arangodb3-apps && \
    rm -f /usr/bin/foxx && \
    rm -f $DB_PACKAGE* data.tar.gz keyfile.pgp && \
    apt-get remove -y --purge gnupg && apt autoremove -y

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