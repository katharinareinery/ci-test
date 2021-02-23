FROM alpine:3.12

RUN set -eux;\
    apk add --no-cache gcc ruby-rake g++ linux-headers;

WORKDIR /workdir

VOLUME /workdir

CMD [ "rake" ]