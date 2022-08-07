# Docker composite of the visualization:

All is configured for you so that you can run CLIENT and IMAGE SERVER
inside a docker container. 

You can run the system as:

`sudo docker-compose build && sudo docker-compose up`

It is probably good idea to also read on system components below:

### 1. Client 
contains the visualization front-end - you probably want to run it inside docker.
The client code is fetched as a git submodule from _RationAI/pathopus_ repository.
The client has to be configured for a localhost: thee correct VIEWER configuration, 
`app/config.php` is provided. Simply copy over this file to the subodule and overwrite
the existing configuration.

##### CORS
Client uses _reverse proxy_ to avoid CORS policy violation. In order to receive
data from custom image server, you have to add a record to the viewer server
configuration: 
 - add reverse proxy record to `client/000-default.conf`, simply follow existing record example:
   - choose a local URL and redirect the server to the desired image server if the request URL matches your local one
   - configure viewer to send requests for images to your local chosen URL
 - don't forget to rebuild the viewer image 

### 2. Server
Contains the visualization image server - you probably want to run it inside docker, and 
provide the data for it in the described folder below. 

##### Custom servers
Up to some point the viewer does not care what server or protocol is used to fetch image tiles.
However, for multiple layers (data group) a synchronous image array requests must be possible. Either that or 
the viewer cannot have more than one data layer. To our knowledge, no image server other than ours supports
this feature. Using our solution is recommended, or contact us to learn how to adjust your image server
to add support for multiple layers.

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

For now, the configuration JSON must be sent manually in order
to open the viewer. We are working on a simple file-browser-based context environment (information system). 

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
 - create your own `client/index.php` version so that the viewer opens on your desired data
    - or open `localhost/dev_setup.php` and input the configuration manually
 - start the docker using `docker-compose build && docker-compose up`
 - in case of problems (images not being served) verify that the IIPImage is really running
   (you can inspect the browser, network tab -> click on URL to see the response manually; 
   or check the docker console)
