# Docker composite of the visualization:

All is configured for you so that you can run all the components: CLIENT, IMAGE SERVER

 and PLAYGROUND inside docker.

The problem is, you might have the need of configuration/changes of
the files at runtime: see different branches for different setup scenarios!


### 1. Client 
contains the visualization front-end - you probably want to run it inside docker.
Client uses _reverse proxy_ to avoid CORS policy violation. You need to adjust
this proxy if you want to change the default configuration.

Note that client has no entrypoint, you have to (for now) configure the JSON
by yourself (see index.php). We will try to write a configuration page...


### 2. Playground
required if you want to use the playground plugin from client. Then, you configure
the visualization with server URL of the Playground server (this). It can run either
within docker, or you can run directly the files without docker for manual debug ($ python app.py).
**You must set up client playground JSON such that server is allways 'localhost', 
easiest is not to specify the server at all and it will be set automatically.**


### 3. Server
contains the visualization back-end - the server accesses images in `data/` folder.
The images path must be relative to this folder in the client's configuration.



### 4. Data
here you put all the data you want the server to see (and serve) - the images
must be in a format IIPImage can read: e.g. a pyramidal TIFF
the tile size of the files dictate how big tiles are, both for the visualization
and the playground (the algorithms will receive tiles/images with just that size)



Scenarios
=========

Sometimes you want to run certain parts outside the docker - external server or
playground on a localhost. You can do this: see other branches that are customized
for such scenarios.
