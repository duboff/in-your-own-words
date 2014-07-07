window['users#show'] = (data) ->
  $(document).ready ->
    $('.cv-link').click (e) ->
      location = this.href
      window.location.href = location