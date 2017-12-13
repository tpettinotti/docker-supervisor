### Description

Manage other container with supervisor

### Usage

docker-compose.yml

```
services:
    supervisor:
        build: ./docker/supervisor
        volumes:
          - ./my_configuration:/etc/supervisor/conf.d/
          - /var/run/docker.sock:/var/run/docker.sock
```
