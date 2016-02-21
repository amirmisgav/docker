#!/bin/bash

pwd

alias

#alias dm='docker-machine'
#alias env_default='eval $(docker-machine env default)'
#alias env_swarm='eval $(docker-machine env --swarm swarm-master)'
#alias env_swarm_00='eval $(docker-machine env swarm-node-00)'
#alias env_swarm_01='eval $(docker-machine env swarm-node-01)'


#env_default
eval $(docker-machine env default)


echo "----  Start Application On Node : swarm-master  ----"

docker $(docker-machine config swarm-master) stop mongodb
docker $(docker-machine config swarm-master) rm mongodb
docker $(docker-machine config swarm-master) run -p 27017:27017 -h tcp://swarm-master  --name 'mongodb' -d mongo

docker $(docker-machine config swarm-master) stop yremote
docker $(docker-machine config swarm-master) rm yremote
docker $(docker-machine config swarm-master)  run -p 3000:3000  -h tcp://swarm-master --name='yremote' --link=mongodb:mongodb -d 54.200.21.126:5000/yremote/yremote:2.0

docker $(docker-machine config swarm-master) stop ynginx
docker $(docker-machine config swarm-master) rm ynginx
docker $(docker-machine config swarm-master) run -p 80:80 -p 443:443 -p 81:81 -h tcp://swarm-master   --link=yremote:yremote --add-host=swarm-master:`docker-machine ip swarm-master` --add-host=swarm-node-00:`docker-machine ip swarm-node-00`  --add-host=swarm-node-01:`docker-machine ip swarm-node-01`  --name ynginx -d 54.200.21.126:5000/yremote/ynginx:2.0


echo "---  Start Application On Node : swarm-node-00 ---"

docker $(docker-machine config swarm-node-00) stop mongodb
docker $(docker-machine config swarm-node-00) rm mongodb
docker $(docker-machine config swarm-node-00) run -p 27017:27017 -h tcp://swarm-node-00  --name 'mongodb' -d mongo

docker $(docker-machine config swarm-node-00) stop yremote
docker $(docker-machine config swarm-node-00) rm yremote
docker $(docker-machine config swarm-node-00)  run -p 3000:3000  -h tcp://swarm-node-00 --name='yremote' --link=mongodb:mongodb -d 54.200.21.126:5000/yremote/yremote:2.0

docker $(docker-machine config swarm-node-00) stop ynginx
docker $(docker-machine config swarm-node-00) rm ynginx
docker $(docker-machine config swarm-node-00) run -p 80:80 -p 443:443 -p 81:81 -h tcp://swarm-node-00   --link=yremote:yremote --add-host=swarm-master:`docker-machine ip swarm-master` --add-host=swarm-node-00:`docker-machine ip swarm-node-00`  --add-host=swarm-node-01:`docker-machine ip swarm-node-01`  --name ynginx -d 54.200.21.126:5000/yremote/ynginx:2.0


echo "---  Start Application On Node : swarm-node-01 ---"

docker $(docker-machine config swarm-node-01) stop mongodb
docker $(docker-machine config swarm-node-01) rm mongodb
docker $(docker-machine config swarm-node-01) run -p 27017:27017 -h tcp://swarm-node-01  --name 'mongodb' -d mongo


docker $(docker-machine config swarm-node-01) stop yremote
docker $(docker-machine config swarm-node-01) rm yremote
docker $(docker-machine config swarm-node-01) run -p 3000:3000  -h tcp://swarm-node-01 --name='yremote' --link=mongodb:mongodb -d 54.200.21.126:5000/yremote/yremote:2.0


docker $(docker-machine config swarm-node-01) stop ynginx
docker $(docker-machine config swarm-node-01) rm ynginx
docker $(docker-machine config swarm-node-01) run -p 80:80 -p 443:443 -p 81:81 -h tcp://swarm-node-01   --link=yremote:yremote --add-host=swarm-master:`docker-machine ip swarm-master` --add-host=swarm-node-00:`docker-machine ip swarm-node-00`  --add-host=swarm-node-01:`docker-machine ip swarm-node-01`  --name ynginx -d 54.200.21.126:5000/yremote/ynginx:2.0


eval $(docker-machine env swarm-master)

echo "---  Cluster Status  Report  ---"

#docker $(docker-machine config swarm-node-00) ps
#docker $(docker-machine config swarm-node-01) ps
docker $(docker-machine config swarm-master) ps

