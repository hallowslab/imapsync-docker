FROM debian:bookworm AS builder
ARG IMAPSYNC_VERSION

# Os deps, installed
RUN apt update && apt install -y apt-file make git cpanminus procps
RUN apt-file update

# perl deps ─ you can have slightly different lists per codename:
COPY debian/bookworm/perl_deps.sh /root/perl_deps.sh
RUN chmod +x /root/perl_deps.sh \
 && /root/perl_deps.sh

# shared build+install:
COPY common/build_imapsync.sh /root/build-imapsync.sh 
RUN /root/build-imapsync.sh "${IMAPSYNC_VERSION}"



FROM debian:bookworm-slim AS final

RUN apt update && apt install -y procps

COPY debian/bookworm/perl_deps.sh /root/perl_deps.sh
RUN chmod +x /root/perl_deps.sh \
 && /root/perl_deps.sh

RUN apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/bin/imapsync /usr/bin/imapsync

ENTRYPOINT []
CMD ["imapsync", "--help"]