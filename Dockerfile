FROM luoruici/node-base

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




