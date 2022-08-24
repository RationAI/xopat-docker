# Pathopus Docker

You can find prepared docker-composite for various scenarios. The main idea is to be able to run individual components 
locally or connect them to various online service endpoints / REST API connectors. The basic docker image (compose) uses
a basic scenario: local client and image server, other folders (will in future) advice on how to adjust `basic` to other
use cases.

### Requirements
The requried code is added through submodules - repositories within RationAI that contains required or optional components.
For the viewer to be able to run, `docker-compose` is necessary.

Please refer to **https://docs.docker.com/compose/


## Fetching the repositories and understanding the structure
This docker project is a tree of repositories that together create use-able system. The structure is descibed below. Each repository is shown with *@* prefix, and usually require some set-up before you can run the docker image(s).

In order to get the repository, you have to clone it and obtain all submodules:

> git submodule update --init --recursive

Then, you have to go through `basic/README.md` and possibly outher READMEs of extensions you wish to use.


##### Warning
_Note that windows docker cannot use shared drive and therefore the data has to be copied over to the image. Using
windows OS to run the image server locally might not be the best idea since all the heavy data has to be duplicated._


### Basic
Basic docker composite that consists of the viewer image and the image-server image running locally, talking to each other. Note that the viewer is not limited to the local server only, but some setup (regarding CORS and data mapping) must be made so that the client receives the image data succesfully.
Other extensions (sibling folders to `basic`) can be attached to this docker setup - just copy over necessary files and adjust `docker-compose.yml`.
For details on how to set-up the core, please refer to `basic/README.md`.

```
.
+-- 
+-- basic    docker image of the viewer and an image server
|   +-- client
|       +-- @pathopus    the viewer
|           +-- @openseadragon    the main viewer library proxy
|       +-- @browser    simple PHP interface for data to the viewer  
|   +-- data
|   +-- server
|       +-- @iipimage    default image server
|   +-- docker-compose.yml    basic compose rules
```
