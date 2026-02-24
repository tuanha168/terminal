#!/bin/bash
set -e

# Kiểm tra USERNAME đã được set
if [ -z "$USERNAME" ]; then
    echo "Error: USERNAME not found in environment"
    USERNAME="default_user"
fi

echo "USERNAME is set to: $USERNAME"

# Build app với environment variables từ Secrets Manager
cd /var/www
export NODE_OPTIONS="--max-old-space-size=1024"
export VUE_APP_USERNAME="$USERNAME"
# yarn build

# Khởi động nginx
echo "Starting nginx..."
nginx -g 'daemon off;' &
NGINX_PID=$!

# Auto shutdown sau 5 phút (300 giây)
echo "Container sẽ tự động shutdown sau 5 phút..."
sleep 300 &
SLEEP_PID=$!

# Đợi hoặc sleep timeout hoặc nginx bị tắt
wait -n $NGINX_PID $SLEEP_PID
EXIT_CODE=$?

# Kill các process còn lại
kill $NGINX_PID 2>/dev/null || true
kill $SLEEP_PID 2>/dev/null || true

echo "Container đang shutdown..."
exit 0
