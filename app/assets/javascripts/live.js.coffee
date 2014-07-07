app = angular.module("app", ["xeditable"], ($locationProvider) ->
    $locationProvider.html5Mode(true);
)

# To make Angular play nice with Turbolinks http://stackoverflow.com/questions/14797935/using-angularjs-with-turbolinks
$(document).on('ready page:load', ->
  angular.bootstrap(document, ['app'])
)

# To pass CSRF token
app.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

app.run (editableOptions) ->
  editableOptions.theme = "bs3"
# bootstrap3 theme.Can be also 'bs2', 'default'

app.controller "EditableFormCtrl", ($scope, $filter, $http, $location) ->
  $scope.user = {
    id: 1,
    name: 'awesome user'
  }

  loadUser = ->
    id = $location.path().split("/")[2]
    url = '/users/' + id + '.json'

    $http.get(url).success( (data) ->
      $scope.user = data
      # console.log(skills)
     ).error( ->
      console.error('Failed to load posts.')
    )
  loadUser()

  $scope.saveUser = ->
    id = $location.path().split("/")[2]
    url = '/users/' + id
    $http.put(url, $scope.user)

app.controller "SkillCtrl", ($scope, $filter, $http, $location) ->
    # //lets create array from a string.
    # $scope.alpha = 'abcdefghijklmopqrstuvwxyz'.split("");
  $scope.skills = ['dev', 'design']
  
  loadSkills = ->
    id = $location.path().split("/")[2]
    url = '/users/' + id + '.json'
    $http.get(url).success( (data) ->
      $scope.skills = data.skills
      console.log($scope.skills)
    ).error( ->
        console.error('Failed to load posts.')
    )
  loadSkills()

  # $scope.saveUser = ->
    # $http.put("/users/15", $scope.user)
  $scope.deleteSkill = (skill_id, index) ->
    id = $location.path().split("/")[2]
    if index != -1
      $scope.skills.splice(index, 1);
      url = "/users/" + id + "/skills/" + skill_id
      $http.put(url, skill_id)

$(document).ready ->
  $(".edit-btn").click ->
    $(".glyphicon-map-marker").hide()
  $(".save-btn").click ->
    $(".glyphicon-map-marker").show()
  $(".cancel-btn").click ->
    $(".glyphicon-map-marker").show()
