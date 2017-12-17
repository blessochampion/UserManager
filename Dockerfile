FROM node:latest

RUN useradd --user-group --create-home --shell /bin/false app

ENV HOME=/usr/src/app

COPY package.json /usr/src/app/package.json

RUN chown -R app:app $HOME/*

WORKDIR $HOME

# Set user and install npm packages
USER app
WORKDIR $HOME
RUN npm install

# Set non-root permissions
USER root
COPY . $HOME
RUN chown -R app:app $HOME/*
USER app

COPY . /usr/src/app

EXPOSE 3000

CMD ["npm", "start"]
