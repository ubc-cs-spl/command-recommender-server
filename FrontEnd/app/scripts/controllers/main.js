'use strict';

angular.module('frontEndApp')
  .controller('RecommendationController', ['$scope', '$http', '$routeParams', '$location', function ($scope, $http, $routeParams, $location) {
        $scope.recommendations = {};
        function getRecommendations(){
                $http.get('/api/get_recommendations/' + $routeParams.userId).success(function(data){
                    if(data.length == 0){
                        $location.url('/');
                    }
                    $scope.recommendations = data;
                });
        }
        getRecommendations();

        $scope.markAsUseful = function(useful){
            var recommendation = this.recommendation;
            $http.get('/api/mark_recommendation/' + recommendation.id, {
                params: {useful: useful}
            }).success(function(data){
               recommendation.useful = useful;
            })
        };

        $scope.isUsefulSelected = function(recommendation){
            if(recommendation === null){
                return false;
            }else{
                return recommendation;
            }
        };

        $scope.isNotUsefulSelected = function(recommendation){
            if(recommendation === null){
                return false;
            }else{
                return !recommendation;
            }
        };
  }]);
