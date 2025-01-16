FROM nginx:latest

RUN apt-get update && \
    apt-get install -y \
    procps \
    curl

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

COPY ./resources/* /usr/share/nginx/html/.

CMD ["nginx", "-g", "daemon off;"]