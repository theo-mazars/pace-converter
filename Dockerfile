# Static site served by nginx. Runs as a non-root user and listens on port 8080.
FROM nginxinc/nginx-unprivileged:stable-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html favicon.svg favicon.png apple-touch-icon.png og-image.png robots.txt sitemap.xml /usr/share/nginx/html/
COPY fonts/ /usr/share/nginx/html/fonts/

EXPOSE 8080
