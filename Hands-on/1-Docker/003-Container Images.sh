# Container Images

## Visit: http://hub.docker.com

docker_login_id="atingupta2005"

docker image ls

docker pull nginx

docker pull nginx:1.11.9

docker image ls

## Images and Their Layers: Discover the Image Cache

docker image ls

docker history nginx:latest

docker history mysql

docker image inspect nginx

## Image Tagging and Pushing to Docker Hub

docker image ls

docker pull mysql/mysql-server

docker image ls

docker pull nginx:mainline

docker image ls

docker image tag nginx $docker_login_id/nginx

docker image tag --help

docker image ls

# Will throw error
docker image push $docker_login_id/nginx

docker login -u $docker_login_id

docker image push $docker_login_id/nginx

docker image ls

## Building Images: The Dockerfile Basics

cd ~/Hands-On/Day1/dockerfile-sample-1/

cat Dockerfile


## Building Images: Running Docker Builds

docker image build -t $docker_login_id/customnginx .

docker image ls

docker image build -t $docker_login_id/customnginx .

docker push $docker_login_id/customnginx

cd
