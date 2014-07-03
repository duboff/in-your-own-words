var app = angular.module("app", ["xeditable"]);

app.run(function(editableOptions) {
    editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});

app.controller('EditableFormCtrl', function($scope, $filter, $http) {
    $scope.user = {
        id: 1,
        name: 'awesome user',
    };

    $scope.saveUser = function() {
        // $scope.user already updated!
        return $http.post('update', $scope.user).error(function(err) {
            if (err.field && err.msg) {
                // err like {
                // field: "name",
                // msg: "Server-side error for this username!"
                // }
                $scope.editableForm.$setError(err.field, err.msg);
            } else {
                // unknown error
                $scope.editableForm.$setError('name', 'Unknown error!');
            }
        });
    };
});