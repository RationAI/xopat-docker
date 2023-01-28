### The Viewer configuration.
Replace `../xopat/config.php` with  `./xopat/config.php` for a localhost docker-ready configuration.

### The Browser configuration.
Place `./browser/config.php` file to the browser repository root. You can also adjust values in the configuration file to adjust the behavior. In case of changes of image server URL, note these have to be reverse-proxy defined in `000-default.conf` (see CORS issues explanation in the parent README).
    