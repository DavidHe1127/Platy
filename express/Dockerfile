FROM node:10
# Create app directory
WORKDIR /usr/src/app

RUN apt-get install curl

ENV INSTALL_PATH /dockerzon
RUN mkdir -p $INSTALL_PATH

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json start.sh ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 8000

VOLUME ["$INSTALL_PATH/public"]

CMD ["./start.sh"]
