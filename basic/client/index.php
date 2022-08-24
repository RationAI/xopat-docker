<?php

define('PATH_TO_IS_MANAGER', 'browser/');

function exception_handler(Throwable $exception) {
    echo "Uncaught exception: " , $exception->getMessage(), "\n";
}

set_exception_handler('exception_handler');

define('FM_CONFIG',  'config/browser/config.php');
require PATH_TO_IS_MANAGER . 'inc/manager.php';
