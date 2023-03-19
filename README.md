# XOpat Docker

You can find prepared docker-composite for various scenarios. The main idea is to be able to run individual components locally or connect them to various online service endpoints / REST API connectors. The basic docker image (compose) uses a basic scenario: local client and image server, other folders add other containers 
with abilities to the system.

### Requirements
For the viewer to be able to run, `docker-compose` is necessary.
Please refer to **https://docs.docker.com/compose/

## Fetching the repositories and understanding the structure
To run the basic scenario, please refer to `templates/basic/README.md`. For extensions, refer to  `templates/[extension]/README.md` first if you wish to use it.

## CtrlC CtrlV - The Way Of Legends

The following command stream supposes that you have git and docker compose installed.

```
# clone repositories - requires git
 git clone https://github.com/RationAI/xopat-docker.git && cd xopat-docker
 docker compose build
 docker compose up  
```
Before running the viewer (by default, the address is `http://localhost:8080`), put some [data](https://iipimage.sourceforge.io/documentation/images/)
inside the `./data/` folder to view. Note that some elements might require write rights to this folder, so before running the system you
can run `mkdir data && chmod a+rwx data`. Based on your scenarios you can adjust the rights, but you should make sure `www-data` user inside
the docker can read (and possibly write to) this directory. It is always mounted as `/var/www/data/` inside docker.


If you have docker compose as a part of docker system, run `docker compose`. Otherwise, 
`docker-compose` command will work.

When updating, simply use
> `git pull && docker compose build`

## Entering containers
Containers are named, so in order to execute a code inside the container you can use its name. For the
basic container the name is `viewer`. Entering its shell can thus be done as:
> docker exec -it viewer bash

### Advanced
SSH Tunelling to VS Code with running containers:
 - install remote _ssh extension_ and _dev containers_ and make sure your OS has a ssh private key configured (`ssh-agent`)
 - `docker context create xo_code --docker "host=ssh://username@localhost:8080"`
 - `Ctrl+Shift+P` in VS Code and issue the _Attach to running container_ command