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
      .when('/:userId', {
        templateUrl: 'views/main.html',
        controller: 'RecommendationController'
      })
        .when('/', {
            templateUrl: 'views/invalid-user.html'
        })
      .otherwise({
        redirectTo: '/'
      });
  }).directive('navigation', function(){
        return {
            restrict: 'E',
            templateUrl: 'views/navigation-element.html'
        };
    });
