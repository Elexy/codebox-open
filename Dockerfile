FROM ubuntu:14.04

RUN apt-get update && \
        apt-get install -y make g++ python git curl && \
        curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - && \
        apt-get install -y nodejs

RUN echo "registry=https://registry.npm.taobao.org" > /root/.npmrc
RUN npm install -g gulp

RUN mkdir -p /root/.codebox/packages

ADD ./bin /codebox/bin
ADD ./editor /codebox/editor
ADD ./lib /codebox/lib
ADD ./packages /codebox/packages
ADD ./.editorconfig /codebox/.editorconfig
ADD ./gulpfile.js /codebox/gulpfile.js
ADD ./package.json /codebox/package.json


RUN cd /codebox && npm install
RUN cd /codebox && gulp
RUN cd /codebox && bin/codebox.js install

EXPOSE 8000

WORKDIR /workspace

CMD ["/codebox/bin/codebox.js", "run", "-n", "0.0.0.0", "-p", "8000", "."]




