var app = angular.module('app', ['ui.router', 'ngAnimate']);

app.config([
    '$controllerProvider', 
    '$compileProvider', 
    '$filterProvider', 
    '$provide', 
    '$animationProvider',
    '$interpolateProvider',
    '$locationProvider', 
    '$stateProvider', 
    '$urlRouterProvider', 
    function(
        $controllerProvider, 
        $compileProvider, 
        $filterProvider, 
        $provide, 
        $animationProvider,
        $interpolateProvider,
        $locationProvider, 
        $stateProvider, 
        $urlRouterProvider
    ){
        // Save references to the providers
        app.lazy = {
            controller: $controllerProvider.register,
            directive:  $compileProvider.directive,
            filter:     $filterProvider.register,
            factory:    $provide.factory,
            service:    $provide.service,
            animation:  $animationProvider.register
        };

        // Change Angular template syntax to not conflict with Twig.
        $interpolateProvider.startSymbol('[[')
                            .endSymbol(']]');

        // define routes, etc.
        $locationProvider.html5Mode(true)
                         .hashPrefix('!');
    }
]);