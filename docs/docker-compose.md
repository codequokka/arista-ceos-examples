docker
======

The network diagram will be created
-----------------------------------
```
+-----+ e1   e1 +-----+
|     +---------+     |
|ceos1|         |ceos2|
|     +---------+     |
+-----+ e2   e2 +-----+
```

Create docker instances and networks
------------------------------------
```
$ export DOCKER_COMPOSE_FILE=./docker-compose/docker-compose.yml 

$ docker-compose -f $DOCKER_COMPOSE_FILE up -d
[+] Running 5/5
 ⠿ Network docker-compose_mgmt      Created  0.0s
 ⠿ Network docker-compose_net12     Created  0.0s
 ⠿ Network docker-compose_net21     Created  0.1s
 ⠿ Container docker-compose-ceos2-1 Started  1.2s
 ⠿ Container docker-compose-ceos1-1 Started  0.9s

$ docker-compose -f $DOCKER_COMPOSE_FILE ps
NAME                     COMMAND                   SERVICE             STATUS              PORTS
docker-compose-ceos1-1   "/sbin/init \n system…"   ceos1               running             0.0.0.0:11022->22/tcp, :::11022->22/tcp, 0.0.0.0:11023->23/tcp, :::11023->23/tcp, 0.0.0.0:11080->80/tcp, :::11080->80/tcp, 0.0.0.0:11443->443/tcp, :::11443->443/tcp
docker-compose-ceos2-1   "/sbin/init \n system…"   ceos2               running             0.0.0.0:12022->22/tcp, :::12022->22/tcp, 0.0.0.0:12023->23/tcp, :::12023->23/tcp, 0.0.0.0:12080->80/tcp, :::12080->80/tcp, 0.0.0.0:12443->443/tcp, :::12443->443/tcp
```

Delete docker instances and networks
------------------------------------
```
$ docker-compose -f $DOCKER_COMPOSE_FILE down
[+] Running 5/5
 ⠿ Container docker-compose-ceos2-1  Removed 11.1s
 ⠿ Container docker-compose-ceos1-1  Removed 11.2s
 ⠿ Network docker-compose_net12      Removed 0.2s
 ⠿ Network docker-compose_mgmt       Removed 0.2s
 ⠿ Network docker-compose_net21      Removed 0.1s
```
