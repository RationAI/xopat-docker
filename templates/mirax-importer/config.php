<?php

function _read_env_mirax_importer($name, $default) {
    $value = getenv($name);
    if (empty($value) || $value == "") return $default;
    return $value;
}

const XO_DB_ROOT = "../../xo_db/";
$upload_root = "/var/www/data/";
$safe_mode = false; //e.g. deleting all for testing purposes
$log_file = "$upload_root/log.txt";
$server_root = "/var/www/html/importer/server/";
$analysis_event_name=function ($event) {
    if (!$event) throw new Exception("Event name must be defined! Got '$event'.");
    if ($event === "mirax-importer") return $event;
    return "histopipe_$event";
};
//must have three groups: 1) capture file name without extension 2) capture year 3) capture biopsy
$mirax_pattern = "/^(.*?([0-9]{4})[_-]([0-9]+).*)\.mrxs$/i";
//the server URL where it is deployed ($server_api_url/config.php is this file)
$server_api_url = _read_env_mirax_importer("XO_MIRAX_SERVER_URL", "http://localhost:8081/importer/server");
