<?php

//relative path system in the application
define('VISUALISATION_ROOT', dirname($_SERVER['SCRIPT_NAME'])); //note that this works only if the files that includes config is in the same directory
define('EXTERNAL_SOURCES', 'external');
define('MODULES_FOLDER', 'modules');
define('PLUGINS_FOLDER', 'plugins');
define('OPEN_SEADRAGON', 'osd');

//important to set this right!
define('PROTOCOL', "http://");
define('SERVER', PROTOCOL . $_SERVER['HTTP_HOST']);
define('JS_COOKIE_EXPIRE', 365); //days
define('JS_COOKIE_PATH', "/");
define('JS_COOKIE_SAME_SITE', ""); //default
define('JS_COOKIE_SECURE', ""); //default
define('BG_TILE_SERVER', PROTOCOL . "localhost:8080/iipsrv.fcgi");
define('LAYERS_TILE_SERVER', PROTOCOL . "localhost:8080/iipsrv.fcgi");


define('VISUALISATION_ROOT_ABS_PATH', SERVER . VISUALISATION_ROOT);
define('EXTERNAL_SOURCES_ABS_PATH', VISUALISATION_ROOT_ABS_PATH . "/" . EXTERNAL_SOURCES);
define('MODULES_ABS_PATH', VISUALISATION_ROOT_ABS_PATH . "/" . MODULES_FOLDER);
define('PLUGINS_ABS_PATH', VISUALISATION_ROOT_ABS_PATH . "/" . PLUGINS_FOLDER);

/**
 * Version is attached to javascript
 * sources so that an update is enforced
 * with change
 */
define('VERSION', "1.0.0");

/**
 * Default protocol
 * one-liner javascript expression with two available variables:
 *  - path: server URL
 *  - data: requested images ids/paths (comma-separated if multiple)
 *  - do not use " symbol as this is used to convert the value to string (or escape, e.g. \\")
 */
define('BG_DEFAULT_PROTOCOL', '`${path}?Deepzoom=\${data}.dzi`');
define('BG_DEFAULT_PROTOCOL_PREVIEW', '`${path}?Deepzoom=\${data}_files/0/0_0.jpg`');
define('LAYERS_DEFAULT_PROTOCOL', '`${path}#DeepZoomExt=\${data.join(",")}.dzi`');

/**
 * Headers used to fetch data from image servers
 */
define('COMMON_HEADERS', array());

/**
 * Path/URL to a context page
 * (where user should be offered to go in case of failure)
 */
define('GATEWAY', '../index.php');
