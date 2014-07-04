window['users#show'] = (data) ->
  $(document).ready ->
    $('.cv-link').click (e) ->
      location = this.href
      console.log(location)
      window.location.href = location