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
nginx -s reload

# Auto shutdown sau 5 phút (300 giây)
echo "Container sẽ tự động shutdown sau 5 phút..."
sleep 300 &
SLEEP_PID=$!

# Đợi hoặc sleep timeout hoặc nginx bị tắt
wait -n $NGINX_PID $SLEEP_PID

# Kill các process còn lại
kill $NGINX_PID 2>/dev/null || true
kill $SLEEP_PID 2>/dev/null || true

echo "Container đang shutdown..."
exit 0
