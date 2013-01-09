<?php

if (!isset($_SERVER['ENVIRONMENT']) || $_SERVER['ENVIRONMENT'] != 'prod') {
    $_SERVER['ENVIRONMENT'] = 'dev';
    $_SERVER['DEBUG']       = !(isset($_SERVER['DEBUG']) && !$_SERVER['DEBUG']);
}

require_once __DIR__ . '/app.php';
