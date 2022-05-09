# Docker composite of the visualization:

All is configured for you so that you can run CLIENT and IMAGE SERVER
inside a docker container. 

For the correct VIEWER configuration, `app/config.php` is provided, however,
any API used by plugins is not provided for you and must be set up manually.


`sudo docker-compose build && sudo docker-compose up`


### 1. Client 
contains the visualization front-end - you probably want to run it inside docker.
Client uses _reverse proxy_ to avoid CORS policy violation.

Note that client has no entrypoint, you have to (for now) configure the JSON
by yourself (see index.php). We will try to write a configuration page...

### 2. Server
contains the visualization back-end - you probably want to run it inside docker,
and provide the data for it in the described folder below

### 3. Data
here you put all the data you want the server to see (and serve) - the images
must be in a format IIPImage can read: e.g. a pyramidal TIFF
the tile size of the files dictate how big tiles are, both for the visualization
and the playground (the algorithms will receive tiles/images with just that size)


DO's
 - access the images in `data/` using relative path to this folder (e.g. in the JSON configuration)
 - create your own `client/index.php` version so that the viewer opens on your desired data
    - or open `localhost/dev_setup.php` and input the configuration manually
 - start the docker using `docker-compose build && docker-compose up`
 - in case of problems (images not being served) verify that the IIPImage is really running
   (you can inspect the browser, network tab -> click on URL to see the response manually; 
   or check the docker console)
