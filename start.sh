#!/bin/bash

echo "Starting PHP-FPM..."
/usr/local/sbin/php-fpm --fpm-config /home/container/php-fpm/php-fpm.conf &

echo "Starting Nginx..."
/usr/sbin/nginx -c /home/container/nginx/nginx.conf

echo "Starting Application / Service..."
tail -f /var/log/nginx/error.log 2>/dev/null || wait
