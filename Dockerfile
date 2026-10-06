# Static site served by nginx. Runs as a non-root user and listens on port 8080.
FROM nginxinc/nginx-unprivileged:stable-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html favicon.svg /usr/share/nginx/html/
COPY fonts/ /usr/share/nginx/html/fonts/

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD wget -q --spider http://127.0.0.1:8080/healthz || exit 1
