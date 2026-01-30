#!/bin/bash
set -e

# Đợi environment variables được inject từ Secrets Manager
sleep 2

# Kiểm tra USERNAME đã được set
if [ -z "$USERNAME" ]; then
    echo "Error: USERNAME not found in environment"
    exit 1
fi

echo "USERNAME is set to: $USERNAME"

# Build app với environment variables từ Secrets Manager
cd /var/www
export NODE_OPTIONS="--max-old-space-size=1024"
export VUE_APP_USERNAME="$USERNAME"
yarn build

# Khởi động nginx
exec nginx -g 'daemon off;'
