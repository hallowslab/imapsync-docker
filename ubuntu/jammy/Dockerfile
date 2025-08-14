FROM ubuntu:jammy AS builder
ARG IMAPSYNC_VERSION

# Os deps, installed
RUN apt update && apt install -y apt-file make time git cpanminus procps
RUN apt-file update

# perl deps ─ you can have slightly different lists per codename:
COPY ubuntu/perl_deps.sh /root/perl_deps.sh
RUN chmod +x /root/perl_deps.sh \
 && /root/perl_deps.sh

# shared build+install:
COPY common/build_imapsync.sh /root/build-imapsync.sh 
RUN /root/build-imapsync.sh "${IMAPSYNC_VERSION}"

ENTRYPOINT []
CMD ["imapsync", "--help"]