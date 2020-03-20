FROM node:10

WORKDIR /usr/src/app

RUN apt-get install curl

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 8000

CMD ["node", "index.js"]
