var app;

app = angular.module("app");

app.service('Rubygems', [
  '$http', function($http) {
    var ROOT;
    ROOT = "https://rubygems.org/api/v1";
    return {
      search: function(query) {
        var promise;
        return promise = $http.get("" + ROOT + "/search.json?query=" + query).then(function(response) {
          return response.data;
        });
      }
    };
  }
]);
