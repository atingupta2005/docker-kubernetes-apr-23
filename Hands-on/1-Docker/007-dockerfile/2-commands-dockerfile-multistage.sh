uid=${USER:1:10}

docker build -f Dockerfile-multi-stage-build -t ms_gcc_$uid .

docker images

docker history ms_gcc_$uid

docker rmi ms_gcc_$uid
