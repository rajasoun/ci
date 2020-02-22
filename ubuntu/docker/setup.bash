#!/usr/bin/env bash

function install_docker(){
    sudo snap install docker
}

### Manage Docker as a non-root user
## The Docker daemon binds to a Unix socket instead of a TCP port. 
## By default that Unix socket is owned by the user root and other users can only access it using sudo. 
## The Docker daemon always runs as the root user.


## If you don’t want to preface the docker command with sudo, 
## create a Unix group called docker and add users to it. 
## When the Docker daemon starts, it creates a Unix socket accessible by members of the docker group.

### Security Warning : DEV ONLY SETUP
### The docker group grants privileges equivalent to the root user. 

function configure_docker_as_root_user(){
    # Create the docker group.
    sudo groupadd docker
    # Add your user to the docker group.
    sudo usermod -aG docker $USER
    # On Linux - activate the changes to groups:
    newgrp docker 
}

#Verify docker 
function check_docker(){
    sudo docker run --rm hello-world
}

install_docker
check_docker

# On a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.
# Restart and Log back In 
configure_docker_as_root_user
