var app = angular.module('UserSearch', ['ui.bootstrap'])
    .controller('UserSearchController', function($scope, $http){
        $scope.SearchUsers = function (val) {
            return $http.get('/api/search.json', {
                params: {
                    query: val,
                    limit: 10
                }
            }).then(function(response){
                return response.data.items;
            });
        }
    });