# FROM node:18.12.0-alpine
# FROM node:16-slim
FROM node:18-slim

# for pdf generation
RUN apt-get update \
    && apt-get install -y wget --no-install-recommends \
    && apt-get install -y \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    libgbm1 \
    libxshmfence1 \
    && rm -rf /var/lib/apt/lists/*
    
WORKDIR /sbs
COPY package*.json ./
COPY prisma ./prisma/
COPY nodemon.json ./nodemon.json
COPY .env ./.env
COPY tsconfig.json ./
COPY . ./
RUN npm install -g pnpm
RUN pnpm install
CMD ["pnpm", "start" ]