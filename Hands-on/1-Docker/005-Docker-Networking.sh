uid=${USER:1:10}
echo $uid
docker_login_id="atingupta2005"

#Use the default bridge network
docker network ls
docker run -dit --name alpine1$uid alpine ash
docker run -dit --name alpine2$uid alpine ash
docker network inspect bridge
docker exec -it alpine1$uid sh
ip addr show
ping google.com -c 4
exit
docker stop alpine1$uid; docker rm alpine1$uid
docker stop alpine2$uid; docker rm alpine2$uid

docker network create --driver bridge $uid-alpine-net
docker network ls
docker network inspect $uid-alpine-net

#Now lets create 4 containers and attach those to the network
docker run -dit -e uid=$uid --name $uid-alpine1 --network $uid-alpine-net alpine ash
docker run -dit -e uid=$uid --name $uid-alpine2 --network $uid-alpine-net alpine ash
docker run -dit -e uid=$uid --name $uid-alpine3 alpine ash   # Will be connected to bridge
docker run -dit -e uid=$uid --name $uid-alpine4 --network $uid-alpine-net alpine ash
docker network connect bridge $uid-alpine4            # Connected to 2 networks
docker container ls # docker ps
docker network inspect bridge
docker network inspect $uid-alpine-net

docker exec -it  $uid-alpine1 sh
ping $uid-alpine2 -c 4
ping $uid-alpine3 -c 4
ping $uid-alpine4 -c 4
exit

#Finally Stop and remove all containers and the alpine-net network.
docker container stop $uid-alpine1 $uid-alpine2 $uid-alpine3 $uid-alpine4
docker container rm $uid-alpine1 $uid-alpine2 $uid-alpine3 $uid-alpine4
docker network rm $uid-alpine-net

#Networking using the host network
docker run --rm -d --network host --name nginx_$uid nginx
curl localhost:80

#Verify which process is bound to port 80, using the netstat command
sudo netstat -tulpn | grep :80

docker container ls -a
sudo docker container stop nginx_$uid
