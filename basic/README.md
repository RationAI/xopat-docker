# Docker composite of the visualization:

All is configured for you so that you can run CLIENT and IMAGE SERVER
inside a docker container. 


## CtrlC CtrlV - The Way Of Legends

The following command stream supposes that you have git, npm, grunt, docker compose installed. For details on OpenSeadragon building (grunt), see https://github.com/Aiosa/openseadragon/blob/master/CONTRIBUTING.md
```
# clone repositories - requires git
 git clone https://github.com/RationAI/pathopus-docker.git
 cd pathopus-docker && git submodule update --init --recursive
# build openseadragon library - requires npm, grunt 
 cd basic/client/pathopus/openseadragon && npm install
# setup configuration of browser and viewer for localhost
 cd ../../  
 cp config/pathopus/config.php pathopus/
 cp config/browser/index.php .
# build and run docker - requires docker compose
 cd ../
 docker compose build
 docker compose up  
```
This set of command should work for you on bash-like terminal, unless you encouter some (usually version based) problems. For more details, read below.

## Understanding The Process

You can run the system as:

> `docker compose build && docker compose up`

if you have docker compose as a part of docker command (newer versions) or

> `docker-compose build && docker-compose up`

in case you have it installed as a detached program. But before you do, all components must be configured appropriately. Everything is ready and you just have to run some commands or copy files. In case of problems, read our Troubleshooting FAQ.


### 1. Client 
contains the visualization front-end - you probably want to run it inside docker.
The client has to be configured to be used inside docker over localhost: a valid `client/config/config.php` file is provided: simply copy over this file to the pathopus subodule and overwrite the existing configuration.
The pathopus viewer depends on OpenSeadragon. Please, refer to `client/config/INSTRUCTIONS.md`.
The browser ... todo
 
### 2. Server
Contains the visualization image server - you probably want to run it inside docker, and provide the data for it in the described folder below. 


### 3. Data
Here you put all the data you want the server to see (and serve) - the images
must be in a format IIPImage (or a server of your choice) can read: e.g. a pyramidal TIFF.
The tile size of the files dictate how big tiles are, both for the visualization
and the playground (the algorithms will receive tiles/images with just that size).

## On viewer:
The viewer renders the content into two logical groups:
 - **image group** - an image no post-processing or visualisation is applied on, contains usually a tissue scan
 - **data group** - a collection of one or more images that are post-processed and shown atop each other; all of 
them atop the **image** group

## On data: using our image server
The only restrictions on data when using our image server are
 - data in pyramidal TIFFs
 - images sent in the **data group** must have the same, rectangular, tile width
	- a server able to handle synchronous tile data array requests, in case you want more than one layer
	- preferrably, not necessarily, of the same resolution (the lowest common is used)

Note that the viewer's high flexibility allows for custom scenarios and restrictions and simple adjustments.
Do not be afraid to contact us if you want a custom behaviour.

DO's
 - access the images in `data/` using relative path to this folder (e.g. in the JSON configuration)
 - in case of problems (images not being served) verify that the IIPImage is really running
   (you can inspect the browser, network tab -> click on URL to see the response manually; 
   or check the docker console) and the data you are trying to read is present in the `data` folder.


### Troubleshooting
There might be various points of failure during the setup process. Most likely the problem lies in different tools versions or different OS setup.

#### Fetching of the repository hierarchy (submodule) fails 
Simply copy over manually downloaded version of that repository using
`git clone <url>`. URL's of all submodules can be found in the root directory in `/.gitmodules` file.

#### Node.js failures (npm install ...)
Try the lates LTS version of Node.js. Try to delete `node_modules/` folder and run `npm install` again. OpenSeadragon might also take a while to download all dependencies, the testing library downloads the whole chromium engine. You can also try to build the OpenSeadragon library independently and place the built files inside `pathopus/openseadragon/build/openseadragon/` folder.

#### Image server dies after `docker-compose up`
Try to run the system again.

#### General problems with docker images and networking
In case of data loading problems (Image server seems to not to respond) please verify that:

Both client and server apache are running.

Open the viewer in Web Developer Tools and verify that there is no CORS violation policy issue (should not be the case, if so contact us).

In case components cannot talk to each other, verify that the `config.php` file is correctly set up, `000-default.conf` file contains correct proxy redirects (client requests images on it`s localhost and these are redirected to the image server container).

Advanced: enter both containers while running:
> `docker ps -a`
to get ID's of your images (while running!) and enter image using
> `docker exec -it bash`.
Inspect the output of `/var/log/apache2/error.log` files to check any errors. Check the accessibility of other docker component using (for example from server): `curl -I http://client:8080/` or (from client) `curl -I http://server:9000/iipsrv.fcgi` - you should get HTTP 200 response.


### Advanced: modifications

Modifying port numbers or component URLs unfortunately involves appropriate changes in many configuration files. Please, use some search utility for files to reflect your changes.
Below, you will find hints and examples on several easier customizations you can perform.

##### Changing Viewer Port Number - The Easy Way Out
port mapping in `docker-compose.yml` has `XXXX:YYYY` format: you are mapping your machine port `XXXX` to the container's port `YYYY`. By default, the viewer runs on your machine localhost port 8080 which is mapped to container port 8080. If you want to access the front-end on `http://localhost/` you have to set port mapping for the client service to `80:8080`.
    
##### Changing Viewer Port Number Within The Container
A nice example of how (as of now) changes to the default configuration are unfriendly. The viewer runs by default on 8080. In order to change this value, you have to:
 - change the browser configuration - it has to know how to access the viewer, also the browser will change it's port it runs on
 - change the viewer configuration - image (and other) server(s) are sent to localhost and redirected from there to different addresses. All URL's with localhost have to be adjusted, mainly plugins in their `include.json` file that cannot read the port number dynamically.
 - change the client apache configuration: replace 8080 in `000-default.conf`
 - change the docker compose specification: the client service has to publish correct ports
    - for port mapping hint see the previous section
 
##### Custom Image Server & CORS
Client uses _reverse proxy_ to avoid CORS policy violation. In order to receive
data from custom image server, you have to add a record to the viewer server
configuration: 
 - add reverse proxy record to `client/000-default.conf`, simply follow existing record example:
   - choose a local URL and redirect the server to the desired image server if the request URL matches your local one
   - configure viewer to send requests for images to your local chosen URL
 - reverse proxy also makes changing image server URL easier - client still accesses it's localhost. But if you change also this value, don't forget to replace necessary links to the image server (the viewer and the browser configuration).
 - don't forget to rebuild the viewer image 


##### Custom Image Servers
Up to some point the viewer does not care what server or protocol is used to fetch image tiles.
However, for multiple layers (data group) a synchronous image array requests must be possible. Either that or 
the viewer cannot have more than one data layer. To our knowledge, no image server other than ours supports
this feature. Using our solution is recommended, or contact us to learn how to adjust your image server
to add support for multiple layers.


