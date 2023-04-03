# Creating and Using Containers

uid=${USER:1:10}
echo $uid

## Starting a Nginx Web Server

docker container run --name nginx$uid --publish 80$uid:80 --detach nginx

docker container ls

docker container stop nginx$uid

docker container ls

docker container ls -a

docker container rm nginx$uid

docker container ls -a

## What's Going On In Containers: CLI Process Monitoring

docker container run -d --name nginx$uid nginx

docker container run -d --name mysql$uid  -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql

docker container ls

docker container top mysql$uid

docker container top nginx$uid

docker container inspect mysql$uid

docker container stats

## Node: Press CTRL+C to come out of Docker Stats

docker container ls -a

## Getting a Shell Inside Containers

docker container run -it --name proxy$uid nginx bash
exit

docker container ls

docker container ls -a

docker container run -it --name ubuntu$uid ubuntu
exit

docker container ls -a

docker container start -ai ubuntu$uid
exit

docker container exec -it mysql$uid bash
exit

docker container ls -a

docker container rm -f mysql$uid nginx$uid ubuntu$uid proxy$uid

docker container ls -a
