<?php

function xo_env($name, $default) {
    $value = getenv($name);
    if (empty($value) || $value == "") return $default;
    return $value;
}

//Access
defined('XO_DB_DRIVER') || define('XO_DB_DRIVER', xo_env('XO_DB_DRIVER', 'pgsql'));
defined('XO_DB_NAME') || define('XO_DB_NAME', xo_env('XO_DB_NAME', 'postgresDB'));
defined('XO_DB_USER') || define('XO_DB_USER', xo_env('XO_DB_USER', 'postgres'));
defined('XO_DB_PASS') || define('XO_DB_PASS', xo_env('XO_DB_PASS', '123456789'));
defined('XO_DB_HOST') || define('XO_DB_HOST', xo_env('XO_DB_HOST', 'localhost'));
defined('XO_DB_PORT') || define('XO_DB_PORT', xo_env('XO_DB_PORT', '5432'));
