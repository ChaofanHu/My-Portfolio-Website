FROM node:14

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 8081
EXPOSE 8080

CMD ["sh", "-c", "node server.js & npm start"]
