FROM alpine:3.18
ARG IMAPSYNC_VERSION

# Alpine’s build deps:
RUN apk add --no-cache \
      build-base make gcc g++ libc-dev openssl-dev zlib-dev tzdata bash curl wget git procps

# perl deps ─ you can have slightly different lists per codename:
COPY alpine/perl_deps.sh /root/perl_deps.sh
RUN chmod +x /root/perl_deps.sh \
 && /root/perl_deps.sh

# shared build+install:
COPY common/build_imapsync.sh /root/build-imapsync.sh 
RUN /root/build-imapsync.sh "${IMAPSYNC_VERSION}"

ENTRYPOINT []
CMD ["imapsync", "--help"]
