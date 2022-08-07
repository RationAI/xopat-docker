# Pathopus Docker

You can find prepared docker-composite for various scenarios. The main idea is to be able to run individual components 
locally or connect them to various online service endpoints / REST API connectors. The basic docker image (compose) uses
a basic scenario: local client and image server, other folders (will in future) advice on how to adjust `basic` to other
use cases.

### Requirements
The requried code is added through submodules - repositories within RationAI that contains required or optional components.
For the viewer to be able to run, `docker-compose` is necessary.

Please refer to **https://docs.docker.com/compose/install/**.


##### Warning
_Note that windows docker cannot use shared drive and therefore the data has to be copied over to the image. Using
windows OS to run the image server locally might not be the best idea since all the heavy data has to be duplicated._


### Base
Basic docker composite that consists of the viewer image and the image-server image running locally, talking to 
each other. Note that the viewer is not limited to the local server only, but some setup (regarding CORS) must be made
so that the client receives the image data succesfully.

