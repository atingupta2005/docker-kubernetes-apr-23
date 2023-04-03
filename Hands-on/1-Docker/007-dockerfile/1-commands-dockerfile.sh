uid=${USER:1:10}

docker build -t custom_nginx_$uid .

docker images

docker history custom_nginx_$uid

docker rmi custom_nginx_$uid
