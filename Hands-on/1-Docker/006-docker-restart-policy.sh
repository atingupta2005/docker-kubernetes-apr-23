## Start containers automatically
### Use a restart policy
- To configure the restart policy for a container, use the --restart flag when using the docker run command. The value of the --restart flag can be any of the following:
 - no: Do not automatically restart the container. (the default)
 - on-failure[:max-retries]: Restart the container if it exits due to an error, which manifests as a non-zero exit code. Optionally, limit the number of times the Docker daemon attempts to restart the container using the :max-retries option.
 - always: Always restart the container if it stops. If it is manually stopped, it is restarted only when Docker daemon restarts or the container itself is manually restarted. (See the second bullet listed in restart policy details)
 - unless-stopped: Similar to always, except that when the container is stopped (manually or otherwise), it is not restarted even after Docker daemon restarts.

uid=${USER:1:10}
echo $uid

# Never run this command on Production
docker ps -aq | xargs docker stop | xargs docker rm


docker run --name redis$uid -d --restart unless-stopped redis

docker update --restart unless-stopped redis$uid


## Multi-stage builds
- Multi-stage builds are useful to anyone who has struggled to optimize Dockerfiles while keeping them easy to read and maintain.
- One of the most challenging things about building images is keeping the image size down
- Each RUN, COPY, and ADD instruction in the Dockerfile adds a layer to the image, and you need to remember to clean up any artifacts you don’t need before moving on to the next layer. 
- Refer: multi-stage-build.yaml

cd ~/Hands-On/Day2
docker builder prune
docker build -t multistageexmp$uid -f Dockerfile-multi-stage-build .
