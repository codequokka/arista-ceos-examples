(This document uses 4.29.0.2F as an example, but the following instructions apply to all releases starting 4.21.0F)

# import the downloaded cEOS-lab.tar.xz image
docker import cEOS-lab.tar.xz ceos:4.29.0.2F

```
$ docker import ./images/cEOS64-lab-4.29.0.2F.tar.xz ceos:4.29.0.2F
sha256:5523992a88637ee3a93ec5c7278ab48871bd45cbc7b53f8c443dafadec6dc8c3

$ docker images ceos
REPOSITORY   TAG         IMAGE ID       CREATED          SIZE
ceos         4.29.0.2F   5523992a8863   13 seconds ago   2.04GB
```

# create docker instances with needed environment variables
docker create --name=ceos1 --privileged -e INTFTYPE=eth -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceos:4.29.0.2F /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
docker create --name=ceos2 --privileged -e INTFTYPE=eth -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceos:4.29.0.2F /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker

```
$ docker create --name=ceos1 --privileged -e INTFTYPE=eth -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceos:4.29.0.2F /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
a36a2a3764c913d6b36cbd5409196d47defcce8c1be38f8e1cb47ebdb212405d

$ docker create --name=ceos2 --privileged -e INTFTYPE=eth -e ETBA=1 -e SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 -e CEOS=1 -e EOS_PLATFORM=ceoslab -e container=docker -i -t ceos:4.29.0.2F /sbin/init systemd.setenv=INTFTYPE=eth systemd.setenv=ETBA=1 systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1 systemd.setenv=CEOS=1 systemd.setenv=EOS_PLATFORM=ceoslab systemd.setenv=container=docker
acfb5ad40825ad2a41d57790e04cd1f9aaab210722524cf847a973071a17ee79

$ docker container ls -a
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS    PORTS     NAMES
acfb5ad40825   ceos:4.29.0.2F   "/sbin/init systemd.…"   3 seconds ago    Created             ceos2
a36a2a3764c9   ceos:4.29.0.2F   "/sbin/init systemd.…"   11 seconds ago   Created             ceos1
```

# create docker networks
docker network create net1
docker network create net2

```
+-----+ e1   e1 +-----+
|     +---------+     |
|ceos1|         |ceos2|
|     +---------+     |
+-----+ e2   e2 +-----+
```

```
$ docker network create net1
e93f52e093ffda71fa09b1b187e9f223d12fef45a5543bc57636ec4121db5723

$ docker network create net2
2ef0dee1d76d21635d203f632ba108dc89217f7376ec94b2d26242da939ef81c

$ docker network ls --filter=name=net
NETWORK ID     NAME      DRIVER    SCOPE
e93f52e093ff   net1      bridge    local
2ef0dee1d76d   net2      bridge    local
```

# connect docker instances to the networks
docker network connect net1 ceos1
docker network connect net1 ceos2
docker network connect net2 ceos1
docker network connect net2 ceos2

```
$ docker network connect net1 ceos1
$ docker network connect net1 ceos2
$ docker network connect net2 ceos1
$ docker network connect net2 ceos2

$ docker container inspect ceos1 | jq '.[].NetworkSettings.Networks'
{
  "bridge": {
    "IPAMConfig": null,
    "Links": null,
    "Aliases": null,
    "NetworkID": "",
    "EndpointID": "",
    "Gateway": "",
    "IPAddress": "",
    "IPPrefixLen": 0,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "MacAddress": "",
    "DriverOpts": null
  },
  "net1": {
    "IPAMConfig": {},
    "Links": null,
    "Aliases": [
      "a36a2a3764c9"
    ],
    "NetworkID": "",
    "EndpointID": "",
    "Gateway": "",
    "IPAddress": "",
    "IPPrefixLen": 0,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "MacAddress": "",
    "DriverOpts": {}
  },
  "net2": {
    "IPAMConfig": {},
    "Links": null,
    "Aliases": [
      "a36a2a3764c9"
    ],
    "NetworkID": "",
    "EndpointID": "",
    "Gateway": "",
    "IPAddress": "",
    "IPPrefixLen": 0,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "MacAddress": "",
    "DriverOpts": {}
  }
}

$ docker container inspect ceos2 | jq '.[].NetworkSettings.Networks'
{
  "bridge": {
    "IPAMConfig": null,
    "Links": null,
    "Aliases": null,
    "NetworkID": "",
    "EndpointID": "",
    "Gateway": "",
    "IPAddress": "",
    "IPPrefixLen": 0,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "MacAddress": "",
    "DriverOpts": null
  },
  "net1": {
    "IPAMConfig": {},
    "Links": null,
    "Aliases": [
      "acfb5ad40825"
    ],
    "NetworkID": "",
    "EndpointID": "",
    "Gateway": "",
    "IPAddress": "",
    "IPPrefixLen": 0,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "MacAddress": "",
    "DriverOpts": {}
  },
  "net2": {
    "IPAMConfig": {},
    "Links": null,
    "Aliases": [
      "acfb5ad40825"
    ],
    "NetworkID": "",
    "EndpointID": "",
    "Gateway": "",
    "IPAddress": "",
    "IPPrefixLen": 0,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "MacAddress": "",
    "DriverOpts": {}
  }
}
```

# start the instances
docker start ceos1
docker start ceos2

```
$ docker start ceos1
ceos1

$ docker start ceos2
ceos2
```

# wait for a few minutes for all EOS agents to start
```
$ docker container ls
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS              PORTS     NAMES
acfb5ad40825   ceos:4.29.0.2F   "/sbin/init systemd.…"   14 minutes ago   Up About a minute             ceos2
a36a2a3764c9   ceos:4.29.0.2F   "/sbin/init systemd.…"   15 minutes ago   Up About a minute             ceos1
```

# issue 'Cli' command to be presented with EOS CLI.

core@core-01 ~ $ docker exec -it ceos1 Cli
localhost>en

localhost#show version
Arista cEOSLab
Hardware version:
Serial number:       N/A
System MAC address:  2623.a993.5502

Software image version: 4.21.0F
Architecture:           i386
Internal build version: 4.21.0F-9441269.4210F
Internal build ID:      0e81f168-216d-4896-b345-5b70ca08f5df

cEOS tools version: 1.1

Uptime:                 7 hours and 27 minutes
Total memory:           8170952 kB
Free memory:            6449840 kB

localhost#show interfaces status
Port       Name        Status       Vlan     Duplex Speed  Type            Flags
Et1                    connected    1        full   unconf EbraTestPhyPort
Et2                    connected    1        full   unconf EbraTestPhyPort

```
❯ docker exec -it ceos1 Cli
a36a2a3764c9>show version
Arista cEOSLab
Hardware version: 
Serial number: 3E816185A248CBD73AA54BDBC72F058E
Hardware MAC address: 0242.ac20.996c
System MAC address: 0242.ac20.996c

Software image version: 4.29.0.2F-29226602.42902F (engineering build)
Architecture: x86_64
Internal build version: 4.29.0.2F-29226602.42902F
Internal build ID: b32bd8f9-3baf-4332-8f58-45e1afe2f695
Image format version: 1.0
Image optimization: None

cEOS tools version: 1.1
Kernel version: 5.15.0-53-generic

Uptime: 3 minutes
Total memory: 49222100 kB
Free memory: 42196704 kB

a36a2a3764c9>show interface status
Port       Name   Status       Vlan     Duplex Speed  Type            Flags Encapsulation
Et1               connected    1        full   1G     EbraTestPhyPort                   
Et2               connected    1        full   1G     EbraTestPhyPort                   

$ docker exec -it ceos2 Cli
acfb5ad40825>show version
Arista cEOSLab
Hardware version: 
Serial number: 038FADE026E8A74CFCCBBC38A0799227
Hardware MAC address: 0242.ac97.38c5
System MAC address: 0242.ac97.38c5

Software image version: 4.29.0.2F-29226602.42902F (engineering build)
Architecture: x86_64
Internal build version: 4.29.0.2F-29226602.42902F
Internal build ID: b32bd8f9-3baf-4332-8f58-45e1afe2f695
Image format version: 1.0
Image optimization: None

cEOS tools version: 1.1
Kernel version: 5.15.0-53-generic

Uptime: 4 minutes
Total memory: 49222100 kB
Free memory: 42196508 kB

acfb5ad40825>show interfaces status 
Port       Name   Status       Vlan     Duplex Speed  Type            Flags Encapsulation
Et1               connected    1        full   1G     EbraTestPhyPort                   
Et2               connected    1        full   1G     EbraTestPhyPort 
```

```
$ docker container rm -f ceos1
ceos1
$ docker container rm -f ceos2
ceos2
$ docker network rm net1
net1
$ docker network rm net2
net2

$ docker container ls -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

$ docker network ls --filter=name=net
NETWORK ID   NAME      DRIVER    SCOPE
```
