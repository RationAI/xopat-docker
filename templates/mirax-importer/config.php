<?php

function _read_env_mirax_importer($name, $default) {
    $value = getenv($name);
    if (empty($value) || $value == "") return $default;
    return $value;
}

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
$mirax_pattern = "/^(.*([0-9]{4})[_-]([0-9]+).*)\.mrxs?$/i";
$server_api_url = _read_env_mirax_importer("XO_MIRAX_SERVER_URL", "http://localhost:8081/importer/server");
