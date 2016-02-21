
# This is default docker out side the swarm
# docker-machine create -d virtualbox default
#eval "$(docker-machine env default)"

echo Cleaning old dockers configurations 

echo STOPPING MACHINS 
docker-machine stop swarm-node-00 swarm-node-01 swarm-master

echo REMOVING MACHINES
docker-machine rm -f swarm-node-00 swarm-node-01 swarm-master

echo  
echo Docker Hub as a hosted discovery service. cluster is create using the following token.
echo

token=$(docker run swarm create)
echo token : $token
 
echo
echo create swarm master
echo
docker-machine create -d virtualbox  --swarm  --swarm-master  --swarm-discovery token://$token  swarm-master
echo

eval $(docker-machine env --swarm swarm-master)

echo  create first swarm node - agent : swarm-node-00
docker-machine create -d virtualbox --swarm --swarm-discovery token://$token swarm-node-00
echo

echo create second swarm node - agent  : swarm-node-01
docker-machine create -d virtualbox --swarm --swarm-discovery token://$token  swarm-node-01
echo

# Direct your swarm
eval $(docker-machine env --swarm swarm-master)

docker-machine ls

docker info
