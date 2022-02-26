# Docker composite of the visualization:

### 1. Client 
contains the visualization front-end - you probably want to run it inside docker.
Client uses _reverse proxy_ to avoid CORS policy violation. You need to adjust
this proxy if you want to change the default configuration.

Note that client has no entrypoint, you have to (for now) configure the JSON
by yourself (see index.php). We will try to write a configuration page...


### 2. Playground
required if you want to use the playground plugin from client. Then, you configure
the visualization with server URL of the Playground server (this). It can run either
within docker, or you can run directly the files without docker ($ python app.py).
**You must set up client playground JSON such that server is allways 'localhost', 
easiest is not to specify the server at all and it will be set automatically.**


### 3. Server
contains the visualization back-end - you probably want to run it inside docker, 
or you don't have to run it at all if you have an external one: just don't forget
to add correct server URL and headers to Client/Plaground in case you do


### 4. Data
here you put all the data you want the server to see (and serve) - the images
must be in a format IIPImage can read: e.g. a pyramidal TIFF
the tile size of the files dictate how big tiles are, both for the visualization
and the playground (the algorithms will receive tiles/images with just that size)



Scenarios
=========
Sometimes you want to run in the docker only parts of the composite, either for
easy manipulation (playground) or because you have your own server sitting elsewhere


You don't have an external (IIPImage) server able to serve images but you have your own data
(running all three or server+client only in docker)
 - You can run just the docker as-is
 - You can run just the client and server from the composite and avoid using playground, 
   and run the playground directly using e.g. `$ python app.py`, it will enable you to
   make quick changes to the scripts - in realtime, but you must
   - Notify Client about the change: modify `000-default.conf` and set up correct URL rules
> Let's say I set up my playground at `my_playground.net`: I would change it to the following:
>   ProxyPassMatch   "/init/(.*)"      "http://my_playground.net/init/$1"      retry=0
>   ProxyPassReverse "/init/(.*)"      "http://my_playground.net/init/$1"      retry=0
>   ProxyPassMatch   "/algorithm/(.*)" "http://my_playground.net/algorithm/$1" retry=0       
>   ProxyPassReverse "/algorithm/(.*)" "http://my_playground.net/algorithm/$1" retry=0

You have an external server (how to change the playground is described above)
(running client+playground or client only in docker)
 - You need to change several things so that both the Playground and the Client know 
   where to send the requests to (note that the server does not have to be the same for both..)
   - Client uses reverse proxy: change the server path to the new URL, e.g. if my server listens at
     `https://iipimg.org/iipsrv.fcgi` I change the `000-default.conf` file:
>   ProxyPass /iipsrv.fcgi https://iipimg.org/iipsrv.fcgi
>   ProxyPassReverse /iipsrv.fcgi https://iipimg.org/iipsrv.fcgi
     note that if you need to set authentication headers for the server, you also have to modify 
     `app/config.php`, you do not want to change the server URL there because it just goes to localhost,
     and the proxy redirection happens after (you can change the URL here, but then you avoid reverse proxy
     and the browser will possibly block the response)
   - Playground connects directly to the server, modify `imageserver.py` globals

   
