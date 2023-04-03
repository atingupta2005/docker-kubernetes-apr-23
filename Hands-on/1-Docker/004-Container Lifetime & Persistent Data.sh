# Container Lifetime & Persistent Data: Volumes, Volumes, Volumes

## Persistent Data: Data Volumes

uid=${USER:1:10}
echo $uid
docker_login_id="atingupta2005"

docker pull mysql

docker image inspect mysql

docker container rm -f mysql$uid
docker container run -d --name mysql$uid -e MYSQL_ALLOW_EMPTY_PASSWORD=True mysql

docker container ls

docker container inspect mysql$uid 

docker volume ls

docker container run -d --name mysql_other$uid -e MYSQL_ALLOW_EMPTY_PASSWORD=True mysql

docker volume ls

docker container stop mysql$uid 

docker container stop mysql_other$uid 

docker container ls

docker container ls -a

docker volume ls

docker container rm mysql$uid  mysql_other$uid

docker volume ls

docker container run -d --name mysql$uid  -e MYSQL_ALLOW_EMPTY_PASSWORD=True -v mysql-db$uid:/var/lib/mysql mysql

docker volume ls

docker volume inspect mysql-db$uid

docker container rm -f mysql$uid

docker container run -d --name mysql3$uid  -e MYSQL_ALLOW_EMPTY_PASSWORD=True -v mysql-db3$uid:/var/lib/mysql mysql

docker volume ls

docker container inspect mysql3$uid 

docker volume create --help

## Persistent Data: Bind Mounting

docker container run -d --name nginx$uid -p 80$uid:80 -v tmp_volume:/usr/share/nginx/html nginx

docker container run -d --name nginx2$uid -p 81$uid:80 nginx

docker container exec -it nginx$uid bash
exit

