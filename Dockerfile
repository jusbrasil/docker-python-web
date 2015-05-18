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
RUN echo "America/Sao_Paulo" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata
RUN echo 'pt_BR.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Install Nginx
RUN apt-get install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Replace the default path for VCS dependencies
ENV PIP_SRC /usr/local/src
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
