FROM python:2.7.15

# Set versions as environment variables so that they can be inspected later.
ENV LESSC_VERSION=1.7.5 \
    LIBSASS_VERSION=3.11.2

# Update the package repository
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            wget \
            curl \
            libssl-dev \
            ruby \
            locales

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# Configure timezone and locale
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime; dpkg-reconfigure -f noninteractive tzdata
RUN echo 'pt_BR.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Install Nginx
RUN apt-get install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Replace the default path for VCS dependencies
ENV PIP_SRC /usr/local/src
# Upgrade pip and install Python packages
RUN pip install -U pip && pip install nose pytest mock gunicorn

# Install node packages
RUN npm install -g bower \
        && npm install -g grunt-cli

# Install CSS processors
RUN npm install -g --unsafe-perm \
    less@${LESSC_VERSION} \
    node-sass@${LIBSASS_VERSION}

# Based on python onbuild images
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
