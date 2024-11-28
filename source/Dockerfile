ARG VERSION
ARG TIMEZONE="Europe/Moscow"
ARG TRANS_OPTS="--log-error"

# Stage: downloas source files
# -------------------------------------
FROM alpine/git AS source
ARG VERSION

WORKDIR /pyhss
RUN git clone \
 --shallow-submodules \
 --recurse-submodules \
 --depth 1 \
 --branch ${VERSION} \
 https://github.com/nickvsnetworking/pyhss.git .


# Stage: install
# -------------------------------------
FROM ubuntu:focal AS install

ENV LD_LIBRARY_PATH=/open5gs/install/lib/x86_64-linux-gnu

RUN export DEBIAN_FRONTEND=noninteractive \
 # Synchronize package index
 && apt-get update \
 # Install packages
 && apt-get install -y --no-install-recommends \
        python3-pip python3-dev\
        python3-setuptools \
        python3-wheel \
        ninja-build \
        build-essential \
        flex \
        bison \
        libsctp-dev \
        libgnutls28-dev \
        libgcrypt-dev \
        libssl-dev \
        libidn11-dev \
        libmongoc-dev \
        libbson-dev \
        libyaml-dev \
        meson \
        mongodb \
        curl \
        gnupg \
        ca-certificates \
        libmicrohttpd-dev \
        libcurl4-gnutls-dev \
        libnghttp2-dev \
        libtins-dev \
        libidn11-dev \
        libtalloc-dev \
        libpq-dev \
        libmysqlclient-dev \
        libsystemd-dev \
        python3-psycopg2 \
        vim \
        tcpdump \
        redis-server \
        # Install the 'envsubst' tool, required to process variables in configuration file.
        gettext-base gawk

WORKDIR /pyhss
COPY --from=source /pyhss /pyhss/runtime

RUN pip3 install -r ./runtime/requirements.txt

# Stage: squash
# -------------------------------------
FROM scratch
COPY --from=install / /

WORKDIR /pyhss

COPY *.sh *.yaml ./
RUN chmod +x *.sh

ENTRYPOINT [ "/pyhss/entrypoint.sh" ]
CMD [ "/pyhss/run.sh" ]
