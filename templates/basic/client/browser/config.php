<?php

//Default Image Server Preview URL Maker (for tif pyramid previews)
//Default Image Server Preview URL Maker (for tif pyramid previews)
$image_preview_url_maker = function ($file) {
    return "http://localhost:8080/iipsrv.fcgi?Deepzoom={$file}_files/0/0_0.jpg";
};

define('FM_IMAGE_SERVER_PREVIEW_URL_MAKER', "http://localhost:8080/xopat/index.php");

//Url of the Viewer
define('FM_XOPAT_URL', "http://localhost:8080/xopat/index.php");

// Default language
define('FM_LANG', 'en');

// Auth with login/password (set true/false to enable/disable it)
define('FM_USE_AUTH', true);

// Show or hide files and folders that starts with a dot
define('FM_SHOW_HIDDEN_FILES', false);

// Default timezone for date() and time() - http://php.net/manual/en/timezones.php
define('FM_DEFAULT_TIMEZONE', 'Europe/Prague'); // UTC

// Root path for file manager
define('FM_BROWSE_ROOT', '/var/www/data/');

// Default root for the WSI server
//todo unused
define('FM_IMAGE_SERVER_URL_PATH', FM_BROWSE_ROOT);

// Root url for links in file manager.Relative to FM_HTTP_HOST. Variants: '', 'path/to/subfolder'
// Will not working if $root_path will be outside of server document root
//if front end path and root path differ use a proxy link that will
//translate one url to the other (e.g. using htaccess at SERVER/proxy) and
//files directory with htaccess redirect from front end to root path
// example: RewriteRule $path/to/proxy/(.*)^ /real/absolute/server/url/$1 [L, QSA]
define('FM_HTTP_PATH', FM_BROWSE_ROOT);

// input encoding for iconv
define('FM_ICONV_INPUT_ENC', 'UTF-8');

// date() format for file modification date
define('FM_DATETIME_FORMAT', 'd.m.y H:i');

//Path to the analysis enpoint, set as false if you don't know
define('FM_WSI_ANALYSIS_PAGE', "http://localhost:8081/importer/server/analysis.php");

//Relative or absolute path to the viewer source src folder. Only required for shader configurator.
define('FM_XOPAT_SOURCES', 'http://localhost:8080/xopat/user_setup.php');

// Path to the database repository root
define('XO_DB_ROOT', "../xo_db/");