FROM node:latest
MAINTAINER Elliot Wright <elliot@elliotwright.co>

RUN apt-get -q update && \
    apt-get -qy install git-core redis-server && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g yo generator-hubot coffee-script && \
    adduser --disabled-password --gecos "" yeoman && \
    echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV HOME /home/yeoman

USER yeoman

WORKDIR /home/yeoman

RUN git clone https://github.com/SeerUK/hubot-slack.git hubot && \
    cd hubot && \
    npm install

CMD cd hubot; bin/hubot --adapter slack
