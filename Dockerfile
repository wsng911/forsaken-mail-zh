FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git && \
    git config --global user.email "dev@example.com" && \
    git config --global user.name "dev"

COPY package*.json ./
RUN npm install --production

COPY . .

RUN git init && git add -A && git commit -m "init" || true

EXPOSE 25
EXPOSE 3000

CMD ["npm", "start"]
