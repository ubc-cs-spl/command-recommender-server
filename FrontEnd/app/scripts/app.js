'use strict';

angular
  .module('frontEndApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  }).directive('navigation', function(){
        return {
            restrict: 'E',
            templateUrl: 'views/navigation-element.html'
        }
    });
