# Builder Stage

FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files first (better caching)

COPY package*.json ./

# Install dependencies using npm ()

RUN npm ci --only=production=false

# Copy all source code

COPY . .

# Build argument + environment variables

ARG TMDB_V3_API_KEY

ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}

ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"

# Build the app

RUN npm run build

# Production Stage

FROM nginx:stable-alpine

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

