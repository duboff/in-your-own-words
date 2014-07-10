app = angular.module "app", ["xeditable", 'mediaPlayer']

# To make Angular play nice with Turbolinks http://stackoverflow.com/questions/14797935/using-angularjs-with-turbolinks
# $(document).on('ready page:load', ->
#   angular.bootstrap(document, ['app'])
# )

# To pass CSRF token
app.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

app.run (editableOptions) ->
  editableOptions.theme = "bs3"
# bootstrap3 theme.Can be also 'bs2', 'default'

app.controller "EditableFormCtrl", ($scope, $filter, $http, $window) ->
  $scope.user = {
    id: 1,
    name: 'awesome user'
  }

  loadUser = ->
    href = $window.location.href.split("/")
    id = href[href.length - 1]
    url = '/users/' + id + '.json'

    $http.get(url).success( (data) ->
      $scope.user = data
      # console.log(skills)
     ).error( ->
      console.error('Failed to load posts.')
    )
  loadUser()

  $scope.saveUser = ->
    id = $scope.user.id
    url = '/users/' + id
    console.log(url)
    $http.put(url, $scope.user)

app.controller "SkillCtrl", ($scope, $filter, $http, $window) ->
    # //lets create array from a string.
  $scope.skills = ['dev', 'design']
  
  loadSkills = ->
    href = $window.location.href.split("/")
    id = href[href.length - 1]
    url = '/users/' + id + '.json'
    $http.get(url).success( (data) ->
      $scope.skills = data.skills
    ).error( ->
        console.error('Failed to load skills.')
    )
  loadSkills()

  # $scope.saveUser = ->
  $scope.deleteSkill = (skill_id, index) ->
    href = $window.location.href.split("/")
    id = href[href.length - 1]
    if index != -1
      $scope.skills.splice(index, 1);
      url = "/users/" + id + "/skills/" + skill_id
      $http.put(url, skill_id)

app.controller 'audioDemo', ($scope) ->


$(document).ready ->
  $(".edit-btn").click ->
    $(".glyphicon-map-marker").hide()
  $(".save-btn").click ->
    $(".glyphicon-map-marker").show()
  $(".cancel-btn").click ->
    $(".glyphicon-map-marker").show()
