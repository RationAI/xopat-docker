### The Viewer configuration.
Replace `../pathopus/config.php` with  `./pathopus/config.php` for a localhost docker-ready configuration.

### The Browser configuration.
Place `./browser/index.php` file anywhere where you want to access the front-end gateway (file manager). Moving it to `/basic/client` folder will make the localhost at (default 8080) port open it automatically.
Adjust necessary variables within this file if you want to change the behaviour of the file manager.

### The OpenSeadragon configuration.
Either build the OpenSeadragon library: You will need Node.js installed. After you can use `npm` command, enter `pathopus/openseadragon` and run
> `npm install -g grunt-cli`
if you do not have `grunt` installed. Then
> `npm install && grunt build`
to build the library. For more info, see https://github.com/openseadragon/openseadragon/blob/master/CONTRIBUTING.md
In case of node install failures, delete `node_modules` folder and `package-lock.json` file and try again.

Alernatively, fetch a built version of OpenSeadragon (we recommend using our proxy version code instead of official repository - we check the compatiblity!) and place it under `pathopus/openseadragon/build/openseadragon`.
You should include files:
 - `openseadragon.js`  (+ `.map` file if available)
 - `openseadragon.min.js` the minified version (+ `.map` file if available)
 - `images/*.png` all the library icons
 
 
 ### The Browser configuration
