FROM node:slim AS builder
WORKDIR /var/www/
COPY . .

RUN yarn

FROM nginx:latest
WORKDIR /var/www/

# Install node để có thể chạy yarn build lúc runtime
RUN apt-get update && apt-get install -y curl && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs && npm install -g yarn && apt-get clean

COPY deployment/ecs/default.conf /etc/nginx/conf.d/default.conf

# Copy source code
COPY --from=builder /var/www .

# Copy entrypoint script
COPY deployment/ecs/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN yarn build

EXPOSE 80 443

# ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
