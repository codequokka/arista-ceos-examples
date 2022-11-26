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
$ docker-topo --create docker-topo/2-node.yml
INFO:__main__:Version 2 requires sudo. Restarting script with sudo
INFO:__main__:                                                                                                                       alias ceos1='docker exec -it 2-node_ceos1 Cli'
alias ceos2='docker exec -it 2-node_ceos2 Cli'                                                                                       INFO:__main__:All devices started successfully

$ docker ps
CONTAINER ID   IMAGE            COMMAND                  CREATED         STATUS         PORTS                  NAMES
7f9531092f5c   ceos:4.29.0.2F   "/sbin/init systemd.…"   2 minutes ago   Up 2 minutes   0.0.0.0:10023->22/tcp, :::10023->22/tcp, 0.0.0.0:10124->23/tcp, :::10124->23/tcp, 0.0.0.0:10444->443/tcp, :::10444->443/tcp   2-node_ceos2
4a6e16ef2368   ceos:4.29.0.2F   "/sbin/init systemd.…"   2 minutes ago   Up 2 minutes   0.0.0.0:10022->22/tcp, :::10022->22/tcp, 0.0.0.0:10123->23/tcp, :::10123->23/tcp, 0.0.0.0:10443->443/tcp, :::10443->443/tcp   2-node_ceos1

$ docker network ls --filter=name=2-node                                                                                             NETWORK ID     NAME           DRIVER    SCOPE
7b1adff407ec   2-node_net-0   bridge    local
909f1b810f9d   2-node_net-1   bridge    local
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
