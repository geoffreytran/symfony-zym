<?php

// Environment
$environment = isset($_SERVER['ENVIRONMENT']) ? $_SERVER['ENVIRONMENT']
											  : 'prod';

if ($environment == 'debug') {               
	require_once __DIR__ . '/../vendor/symfony/src/Symfony/Component/ClassLoader/UniversalClassLoader.php';
	require_once __DIR__ . '/../app/autoload.php';
} else {        
	require_once __DIR__ . '/../app/bootstrap.php.cache';
}

require_once __DIR__ . '/../app/AppKernel.php';

use Symfony\Component\HttpFoundation\Request;

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
