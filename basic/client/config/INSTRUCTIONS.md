### The Viewer configuration.
Copy 'config.php' to `../pathopus` for a localhost setup.

### The OpenSeadragon configuration.
Either build the OpenSeadragon library: You will need Node.js installed. After you can use `npm` command, enter `pathopus/openseadragon` and run
> `npm install -g grunt-cli`
if you do not have `grunt` installed. Then
> `npm install && grunt build`
to build the library. For more info, see https://github.com/openseadragon/openseadragon/blob/master/CONTRIBUTING.md
In case of node install failures, delete `node_modules` folder and `package-lock.json` file and try again.

Alernatively, fetch a built version of OpenSeadragon (we recommend using our proxy version code instead of official repository - we check the compatiblity!) and place it under `pathopus/openseadragon/build/openseadragon`.
You should include files:
 - `openseadragon.js`   
 - `openseadragon.min.js` the minified version
 - `images/*.png` the library icons
 
 
 ### The Browser configuration
