<?php

use Symfony\Component\ClassLoader\ApcClassLoader;
use Symfony\Component\Debug\Debug;
use Symfony\Component\HttpFoundation\Request;

$loader = require_once __DIR__.'/../app/bootstrap.php.cache';

$environment = isset($_SERVER['ENVIRONMENT']) ? $_SERVER['ENVIRONMENT']
                                              : 'prod';
// Whether to force debugging
$debug       = isset($_SERVER['DEBUG'])       ? (bool) $_SERVER['DEBUG']      : null;

// Whether to use the internal app cache
$httpCache   = isset($_SERVER['HTTP_CACHE'])  ? (bool) $_SERVER['HTTP_CACHE'] : false;

if ($environment == 'dev' || $environment == 'debug' || $debug) {
    Debug::enable();
} else {

    if (extension_loaded('apc') && ini_get('apc.enabled')) {
        // Use APC for autoloading to improve performance.
        // Change 'sf2' to a unique prefix in order to prevent cache key conflicts
        // with other applications also using APC.
        $loader->unregister();

        $loader = new ApcClassLoader('sf2_class_loader_' . md5(__FILE__), $loader);
        $loader->register(true);
    }
}

require_once __DIR__ . '/../app/AppKernel.php';

// Setup the kernel and handle the request
$kernel = new AppKernel($environment, $debug);

// Http Caching
if ($httpCache) {
    require_once __DIR__ . '/../app/AppCache.php';

    $kernel = new AppCache($kernel);
}

// Handle the request
Request::enableHttpMethodParameterOverride();
$request  = Request::createFromGlobals();

$response = $kernel->handle($request);
$response->send();

$kernel->terminate($request, $response);
