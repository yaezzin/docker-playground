FROM nginx

# 설정파일 경로 /etc/nginx/conf.d/nginx.conf
COPY ./config/nginx.conf /etc/nginx/conf.d/nginx.conf

# Nginx 공식 도커 이미지 경로 /usr/share/nginx/html/
COPY ./html/index.html /usr/share/nginx/html/index.html

ENTRYPOINT ["nginx", "-g", "daemon off;"]