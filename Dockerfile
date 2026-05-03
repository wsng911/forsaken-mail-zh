FROM node:20-alpine

WORKDIR /app

COPY .npmrc* package*.json ./
RUN npm install --production && npm cache clean --force

COPY . .

ENV TZ=Asia/Shanghai
EXPOSE 25
EXPOSE 3000

CMD ["npm", "start"]
