<?php

use Symfony\Component\ClassLoader\ApcClassLoader;
use Symfony\Component\HttpFoundation\Request;

ini_set('xdebug.max_nesting_level', 200);

$environment = isset($_SERVER['ENVIRONMENT']) ? $_SERVER['ENVIRONMENT']
                                              : 'prod';

if ($environment == 'debug') {
    require_once __DIR__ . '/../vendor/symfony/src/Symfony/Component/ClassLoader/UniversalClassLoader.php';
    require_once __DIR__ . '/../app/autoload.php';
} else {
    $loader = require_once __DIR__.'/../app/bootstrap.php.cache';

    if (extension_loaded('apc') && ini_get('apc.enabled')) {
        // Use APC for autoloading to improve performance.
        // Change 'sf2' to a unique prefix in order to prevent cache key conflicts
        // with other applications also using APC.
        $loader = new ApcClassLoader('sf2_class_loader_' . md5(__FILE__), $loader);
        $loader->register(true);
    }
}

require_once __DIR__ . '/../app/AppKernel.php';

// Whether to force debugging
$debug       = isset($_SERVER['DEBUG'])       ? (bool) $_SERVER['DEBUG']      : null;

// Wether to use the internal app cache
$httpCache   = isset($_SERVER['HTTP_CACHE'])  ? (bool) $_SERVER['HTTP_CACHE'] : false;

// Setup the kernel and handle the request
$kernel = new AppKernel($environment, $debug);

// Http Caching
if ($httpCache) {
    require_once __DIR__ . '/../app/AppCache.php';

    $kernel = new AppCache($kernel);
}

// Handle the request
$request  = Request::createFromGlobals();
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);
