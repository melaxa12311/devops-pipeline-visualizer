# Backend
FROM node:20-alpine as backend
WORKDIR /app
COPY backend/package*.json ./
RUN npm install express
COPY backend/server.js ./
EXPOSE 5000
CMD ["node", "server.js"]

