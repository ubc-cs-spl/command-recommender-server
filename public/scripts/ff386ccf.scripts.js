"use strict";angular.module("frontEndApp",["ngCookies","ngResource","ngSanitize","ngRoute","ui.bootstrap"]).config(["$routeProvider",function(a){a.when("/command_detail/:userId",{templateUrl:"../views/command-detail.html",controller:"CommandDetailController"}).when("/recommendations/all/:userId",{templateUrl:"../views/all-recommendations.html",controller:"AllRecommendationsController"}).when("/:userId",{redirectTo:"/recommendations/current/:userId"}).when("/recommendations/:current/:userId",{templateUrl:"../views/current-recommendations.html",controller:"CurrentRecommendationsController"}).when("/",{templateUrl:"../views/invalid-route.html"}).otherwise({redirectTo:"/"})}]).filter("offset",function(){return function(a,b){return b=parseInt(b,10),a.slice(b)}}),angular.module("frontEndApp").controller("CurrentRecommendationsController",["$scope","$routeParams","RecommendationService","NavigationService",function(a,b,c,d){function e(a){if(0==a.length)return[];for(var b=[],c=0,d=0;d<a.length/2;d++)b[d]=a.slice(c,c+2),c+=2;return b}a.filterParams={},a.validUser={},a.initialized=!1,a.algorithmTypes={},a.chunkedRecommendations=[],d.updateNavigation(b.userId,b.current),a.isValidUser=function(){c.isValidUser(b.userId).then(function(b){a.validUser=b})},a.isValidUser(),a.getAlgorithmTypes=function(){return c.getAlgorithmTypes(b.userId).then(function(b){a.algorithmTypes=b,a.currentAlgorithmType=b[0]})},a.getRecommendations=function(){c.getRecommendations(b.userId,b.current,a.currentAlgorithmType).then(function(b){a.chunkedRecommendations=e(b),a.initialized=!0})},a.getAlgorithmTypes().then(function(){a.getRecommendations()}),a.markAsUseful=function(b,d){var e=a.chunkedRecommendations[d];c.markAsUseful(b,e).then()},a.saveRecommendation=function(b,d){var e=a.chunkedRecommendations[d];c.saveRecommendation(b,e).then(function(c){b&&c&&a.chunkedRecommendations.splice(d,1)})},a.isUsefulSelected=function(a){return null==a?!1:a},a.isNotUsefulSelected=function(a){return null==a?!1:!a}}]),angular.module("frontEndApp").controller("NavigationController",["$scope","NavigationService",function(a,b){a.userId={},a.current={},a.$on("navigationUpdated",function(){a.current=b.current,a.userId=b.userId})}]),angular.module("frontEndApp").controller("CommandDetailController",["$scope","$http","$modal","$routeParams","CommandService","NavigationService",function(a,b,c,d,e,f){a.results=[],a.commandUnderEdit={},a.searched=!1,a.filter="no_details",a.currentPage=0,a.itemsPerPage=10,f.updateNavigation(d.userId,"command_detail");var g,h={templateUrl:"views/modals/edit-command.html",controller:"ModalCommandController"};a.search=function(){b.get("api/command_details/filter/command_id",{params:{filter_value:a.searchValue,filter:a.filter}}).success(function(b){a.results=b,a.currentPage=0,a.searched=!0}).error(function(){a.searched=!0})},a.showCommand=function(b,d){e.retrieveCommand(b).then(function(){g=c.open(h),g.result.then(function(b){a.results[d]=b})})}}]),angular.module("frontEndApp").service("RecommendationService",["$http",function(a){this.getRecommendations=function(b,c,d){var e=a.get("/api/get_recommendations/"+b+"/"+c,{params:{algorithm_type:d}}).then(function(a){return a.data});return e},this.markAsUseful=function(b,c){return a.get("/api/mark_recommendation/"+c.id,{params:{useful:b}}).then(function(){return c.useful=b,c})},this.saveRecommendation=function(b,c){return a.get("/api/save_recommendation/"+c.id,{params:{saved:b}}).then(function(){return c.saved=b,!0},function(){return!1})},this.isValidUser=function(b){var c=a.get("/api/users/is_valid/"+b).then(function(a){return a.data.valid},function(){return!1});return c},this.getAlgorithmTypes=function(b){return a.get("api/recommendations/"+b+"/algorithm_types").then(function(a){return a.data},function(){return[]})}}]),angular.module("frontEndApp").service("NavigationService",["$rootScope",function(a){this.userId={},this.current={},this.updateNavigation=function(b,c){this.userId=b,this.current=c,a.$broadcast("navigationUpdated")}}]),angular.module("frontEndApp").controller("AllRecommendationsController",["$scope","$routeParams","$modal","NavigationService","RecommendationService","CommandService",function(a,b,c,d,e,f){a.currentAlgorithmType="MOST_WIDELY_USED",a.validUser={},a.initialized=!1,a.algorithmTypes={},a.currentPage=0,a.itemsPerPage=10,a.recommendations=[];var g,h={templateUrl:"views/modals/edit-command.html",controller:"ModalCommandController"};d.updateNavigation(b.userId,"all"),a.isValidUser=function(){e.isValidUser(b.userId).then(function(b){a.validUser=b})},a.getAlgorithmTypes=function(){return e.getAlgorithmTypes(b.userId).then(function(b){a.algorithmTypes=b,a.currentAlgorithmType=b[0]})},a.getRecommendations=function(){e.getRecommendations(b.userId,"all",a.currentAlgorithmType).then(function(b){a.recommendations=b,a.initialized=!0})},a.isValidUser(),a.getAlgorithmTypes().then(function(){a.getRecommendations()}),a.showCommand=function(b,d){f.retrieveCommand(b).then(function(){g=c.open(h),g.result.then(function(b){a.recommendations[d].command_detail=b})})}}]),angular.module("frontEndApp").service("CommandService",["$http",function(a){this.currentCommand={};var b=this;this.retrieveCommand=function(c){return a.get("api/command_details/"+c+"/show").then(function(a){return b.currentCommand=a.data,a.data},function(){return null})},this.saveCommand=function(b){return a.post("api/command_details/"+b.id+"/update/",{command_name:b.command_name,description:b.description,shortcut:b.shortcut}).then(function(){return!0},function(){return!1})}}]),angular.module("frontEndApp").controller("ModalCommandController",["$scope","$modalInstance","CommandService",function(a,b,c){a.currentCommand=c.currentCommand,a.originalCommand=angular.copy(a.currentCommand),a.saved=!1,a.failedToSave=!1,a.saveCommand=function(){c.saveCommand(a.currentCommand).then(function(b){b?(a.saved=!0,a.failedToSave=!1):(a.saved=!1,a.failedToSave=!0)})},a.cancel=function(){c.command={},b.close(a.saved?a.currentCommand:a.originalCommand)}}]);