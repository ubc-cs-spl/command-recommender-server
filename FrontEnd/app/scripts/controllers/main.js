'use strict';

angular.module('frontEndApp')
  .controller('MainCtrl', ['$scope', '$http', function ($scope, $http) {
        $scope.recommendations = {};
        $scope.testData = 'Some stuff';
        function getRecommendations(){
                $http.get('/get_recommendations/abcdef').success(function(data){
                    $scope.recommendations = data;
                });
        }
        getRecommendations();
  }]);
