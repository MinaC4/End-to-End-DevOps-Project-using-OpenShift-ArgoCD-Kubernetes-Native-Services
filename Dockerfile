# ====================== Builder Stage ======================
FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci --include=dev

COPY . .

ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"

RUN npm run build

# ====================== Production Stage ======================
FROM nginxinc/nginx-unprivileged:stable-alpine

# Copy the built React application
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom nginx configuration for React Router
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

USER 101
CMD ["nginx", "-g", "daemon off;"]
