FROM circleci/golang:1.11-node

ENV APPENGINE_VERSION=1.9.70
ENV HOME=/home/circleci
ENV SDK=https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-${APPENGINE_VERSION}.zip \
    PATH=${HOME}/go_appengine:${PATH}

RUN sudo apt-get update && sudo apt-get install -y \
    musl-dev \
    python-pygments \
    && sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/* \
    && curl -fo /tmp/gae.zip ${SDK} \
    && unzip -q /tmp/gae.zip -d /tmp/ \
    && mv /tmp/go_appengine ${HOME}/go_appengine \
    && rm /tmp/gae.zip

# Install Hugo
ENV HUGO_VERSION 0.30.2
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-64bit

RUN curl -sL -O https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz \
    && tar xzf ${HUGO_BINARY}.tar.gz \
    && sudo mv hugo /usr/local/bin/hugo \
    && rm ${HUGO_BINARY}.tar.gz

# Install util
RUN sudo npm install -g yarn \
    && curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh \
    && curl https://raw.githubusercontent.com/alecthomas/gometalinter/master/scripts/install.sh | sudo -E sh
#RUN goapp get github.com/jstemmer/go-junit-report
