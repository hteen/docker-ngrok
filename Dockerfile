FROM ubuntu:16.04
MAINTAINER hteen <i@hteen.cn>

RUN apt-get update && \
    apt-get install -y build-essential golang git mercurial && \
    mkdir -p /release

RUN git clone https://github.com/tutumcloud/ngrok.git /ngrok

ADD *.sh /

ENV DOMAIN **None**
ENV MY_FILES /myfiles
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :80
ENV HTTPS_ADDR :443

CMD /bin/bash
