app = angular.module("app", ["xeditable"])

app.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])

# defaults = $http.defaults.headers
# defaults.patch = defaults.patch || {}
# defaults.patch['Content-Type'] = 'application/json'

app.run (editableOptions) ->
  editableOptions.theme = "bs3"
# bootstrap3 theme.Can be also 'bs2', 'default'

app.controller "EditableFormCtrl", ($scope, $filter, $http) ->
  $scope.user = {
    id: 1,
    name: 'awesome user'
  }

  loadUser = ->
    $http.get('/users/15.json').success( (data) ->
      $scope.user = data
      # console.log(skills)
     ).error( ->
      console.error('Failed to load posts.')
    )
  loadUser()

app.controller "SkillCtrl", ($scope, $filter, $http) ->
    # //lets create array from a string.
    # $scope.alpha = 'abcdefghijklmopqrstuvwxyz'.split("");
  $scope.skills = ['dev', 'design']
  
  loadSkills = ->
    $http.get('/users/15.json').success( (data) ->
      $scope.skills = data.skills.map (skill) -> skill.name
      console.log($scope.skills)
    ).error( ->
        console.error('Failed to load posts.')
    )
  loadSkills()

$(document).ready ->
  $(".edit-btn").click ->
    $(".glyphicon-map-marker").hide()
  $(".save-btn").click ->
    $(".glyphicon-map-marker").show()
  $(".cancel-btn").click ->
    $(".glyphicon-map-marker").show()