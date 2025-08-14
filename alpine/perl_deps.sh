set -e
# Install build dependencies for Perl modules
# perl-digest-hmac-md5 does not seem to exist? however 
apk add --no-cache perl perl-dev perl-app-cpanminus perl-authen-ntlm perl-cgi perl-crypt-openssl-rsa perl-data-uniqid \
    perl-digest-hmac perl-digest-md5 perl-encode-imaputf7 perl-file-copy-recursive perl-file-tail perl-io-socket-inet6 \
    perl-io-socket-ssl perl-io-tee perl-json perl-html-parser perl-libwww perl-mail-imapclient perl-module-implementation \
    perl-module-runtime perl-net-ssleay perl-package-stash perl-package-stash-xs perl-parse-recdescent perl-readonly perl-regexp-common \
    perl-term-readkey perl-try-tiny perl-unicode-string perl-uri perl-ntlm perl-dist-checkconflicts perl-json-webtoken perl-net-server \
    perl-proc-processtable perl-sys-meminfo perl-module-scandeps perl-par-packer perl-test-deep perl-test-fatal perl-test-mock-guard \
    perl-test-mockobject perl-test-pod perl-test-requires