#!/bin/bash

targets="2-node_cEOS-1 2-node_cEOS-2"


# ------------------------------------------------------
# Set admin password
# ------------------------------------------------------
commands="enable
config
username admin secret arista
write memory
"

for target in $targets
do
    echo "----- $target -----"
    docker exec $target Cli -p 15 -e -c "$commands"
done


# ------------------------------------------------------
# Enable telnet access
# ------------------------------------------------------
commands="enable
config
management telnet
no shutdown
write memory
"

for target in $targets
do
    echo "----- $target -----"
    docker exec $target Cli -p 15 -e -c "$commands"
done


# ------------------------------------------------------
# Enable eAOU access
# ------------------------------------------------------
commands="enable
config
management api http-commands
no shutdown
write memory
"

for target in $targets
do
    echo "----- $target -----"
    docker exec $target Cli -p 15 -e -c "$commands"
done


# ------------------------------------------------------
# Set timezone
# ------------------------------------------------------
commands="enable
config
clock timezone Asia/Tokyo
write memory
"

for target in $targets
do
    echo "----- $target -----"
    docker exec $target Cli -p 15 -e -c "$commands"
done
