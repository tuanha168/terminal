#!/bin/bash
set -e

# Kiểm tra USERNAME đã được set
if [ -z "$USERNAME" ]; then
    echo "Error: USERNAME not found in environment"
    USERNAME="default_user"
fi

echo "USERNAME is set to: $USERNAME"

# Khởi động nginx trước để ALB healthcheck pass
nginx -g 'daemon off;' &
NGINX_PID=$!

# Build app với environment variables từ Secrets Manager
cd /var/www
export NODE_OPTIONS="--max-old-space-size=1024"
export VUE_APP_USERNAME="$USERNAME"
# yarn build

# Đợi build xong, reload nginx
kill -HUP $NGINX_PID
wait $NGINX_PID
