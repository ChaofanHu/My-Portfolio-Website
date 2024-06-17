FROM node:14

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

ARG OUTLOOK_USER
ARG OUTLOOK_PASS
ENV OUTLOOK_USER=$OUTLOOK_USER
ENV OUTLOOK_PASS=$OUTLOOK_PASS

RUN npm run build

EXPOSE 8081
EXPOSE 8080

CMD ["sh", "-c", "node server.js & npm start"]
