FROM debian:bullseye as build

ARG APP_VERSION

RUN case $(uname -m) in \
    x86_64) \
        echo linux-amd64 > /platform ;; \
    aarch64) \
        echo linux-arm64 > /platform ;; \
    *) \
        echo "Unknown architecture: $(uname -m)" \
        exit 1 ;; \
    esac

RUN echo Building $(cat /platform) image for v${APP_VERSION}...

# Installing dependencies
RUN apt-get update
RUN apt-get install -y curl

# Download the teleport binary
RUN mkdir -p /build
WORKDIR /build
RUN curl https://get.gravitational.com/teleport-v${APP_VERSION}-$(cat /platform)-bin.tar.gz -o teleport.tar.gz
RUN tar xfz teleport.tar.gz teleport/teleport

RUN teleport/teleport version

FROM busybox

COPY --from=build /build/teleport/teleport /teleport

RUN < /teleport sha1sum > /teleport.sha1

COPY config.yml.template /config.yml.template

COPY run /run
RUN chmod +x /run

ENV HOST_ROOT=/opt/tpnode

CMD ["/run"]
