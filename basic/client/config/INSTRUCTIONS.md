### The Viewer configuration.
Replace `../pathopus/config.php` with  `./pathopus/config.php` for a localhost docker-ready configuration.

### The Browser configuration.
Place `./browser/config.php` file to the browser repository root. You can also adjust values in the configuration file to adjust the behavior. In case of changes of image server URL, note these have to be reverse-proxy defined in `000-default.conf` (see CORS issues explanation in the parent README).
    
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
 
 
