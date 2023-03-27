<?php
//relative path to xo_db interface
const XO_DB_ROOT = "../../xo_db/";
//where we start uploading
$upload_root = "/var/www/data/";
$log_file = "$upload_root/log.txt";
//where are processing scripts
$server_root = "/var/www/html/importer/server/";
//for database, how events are named
$analysis_event_name=function ($event) {
    if (!$event) throw new Exception("Event name must be defined! Got '$event'.");
    if ($event === "mirax-importer") return $event;
    return "histopipe_$event";
};
