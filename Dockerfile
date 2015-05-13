FROM python:2.7.8

# Update the package repository
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            wget \
            curl \
            nodejs \
            npm \
            locales

# Configure timezone and locale
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "America/Sao_Paulo" > /etc/timezone; dpkg-reconfigure -f tzdata
RUN echo 'pt_BR.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen && dpkg-reconfigure locales

# Install Python packages
RUN pip install nose pytest mock gunicorn

# Install node packages
RUN ln -s /usr/bin/nodejs /usr/bin/node \
        && npm install -g less@1.3.3 \
        && npm install -g phantomjs

# Based on python onbuild images
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD RUN pip install -r requirements.txt

ONBUILD COPY . /usr/src/app
