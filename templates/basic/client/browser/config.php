<?php

function _read_env_browser($name, $default) {
    $value = getenv($name);
    if (empty($value) || $value == "") return $default;
    return $value;
}

//Default Image Server Preview URL Maker (for tif pyramid previews)
//Default Image Server Preview URL Maker (for tif pyramid previews)
$image_preview_url_maker = function ($file) {
    return "/iipsrv/iipsrv.fcgi?Deepzoom={$file}_files/1/0_0.jpg";
};

//Array of folders excluded from listing
$GLOBALS['exclude_folders'] = array(
    '.git'
);

//Url of the Viewer
defined('FM_XOPAT_URL') || define('FM_XOPAT_URL', "/xopat/index.php");

// Default language
defined('FM_LANG') || define('FM_LANG', 'en');

// Auth with login/password (set true/false to enable/disable it)
defined('FM_USE_AUTH') || define('FM_USE_AUTH', true);

// Show or hide files and folders that starts with a dot
defined('FM_SHOW_HIDDEN_FILES') || define('FM_SHOW_HIDDEN_FILES', false);

// Enable highlight.js (https://highlightjs.org/) on view's page
defined('FM_USE_HIGHLIGHTJS') || define('FM_USE_HIGHLIGHTJS', true);
// highlight.js style
defined('FM_HIGHLIGHTJS_STYLE') || define('FM_HIGHLIGHTJS_STYLE', 'vs');

// Default timezone for date() and time() - http://php.net/manual/en/timezones.php
defined('FM_DEFAULT_TIMEZONE') || define('FM_DEFAULT_TIMEZONE', 'Europe/Prague'); // UTC

// Root path for file manager
defined('FM_BROWSE_ROOT') || define('FM_BROWSE_ROOT', '/var/www/data/');

// Default root for the WSI server
//todo unused
defined('FM_IMAGE_SERVER_URL_PATH') || define('FM_IMAGE_SERVER_URL_PATH', FM_BROWSE_ROOT);

defined('FM_ADVANCED_MODE') || define('FM_ADVANCED_MODE', false);

// Root url for links in file manager.Relative to FM_HTTP_HOST. Variants: '', 'path/to/subfolder'
// Will not working if $root_path will be outside of server document root
//if front end path and root path differ use a proxy link that will
//translate one url to the other (e.g. using htaccess at SERVER/proxy) and
//files directory with htaccess redirect from front end to root path
// example: RewriteRule $path/to/proxy/(.*)^ /real/absolute/server/url/$1 [L, QSA]
defined('FM_HTTP_PATH') || define('FM_HTTP_PATH', FM_BROWSE_ROOT);

// Root url for the source files, by default relative, the domain is appended automatically (JS, assets)
defined('FM_URL') || define('FM_URL', PATH_TO_IS_MANAGER ?? '');

// URL path enabling direct access to files, the server can define access to the folder at given prefix
defined('FM_DIRECT_FILES_URL') || define('FM_DIRECT_FILES_URL', '/data/');

defined('FM_HTTP_HOST') || define('FM_HTTP_HOST', $_SERVER['HTTP_HOST']);

// input encoding for iconv
defined('FM_ICONV_INPUT_ENC') || define('FM_ICONV_INPUT_ENC', 'UTF-8');

// date() format for file modification date
defined('FM_DATETIME_FORMAT') || define('FM_DATETIME_FORMAT', 'd.m.y H:i');

// allowed upload file extensions, e.g. 'gif,png,jpg'
defined('FM_EXTENSION') || define('FM_EXTENSION', '');

//Path to the analysis enpoint, set as false if you don't know, read from env -> unable to use relative URL
defined('FM_WSI_ANALYSIS_PAGE') || 
    define('FM_WSI_ANALYSIS_PAGE', _read_env_browser("XO_BROWSER_ANALYSIS", "http://localhost:8081/importer/server/analysis.php"));

//Relative or absolute path to the viewer source src folder. Only required for shader configurator.
defined('FM_XOPAT_SOURCES') || define('FM_XOPAT_SOURCES', '/xopat/user_setup.php');

// Path to the database repository root relative to this repository
defined('FM_XO_DB_ROOT') || define('FM_XO_DB_ROOT', "../xo_db/");
