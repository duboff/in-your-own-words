$(document).ready ->
  # stop playback
  playing = false

  stopPlayback = ->
      
  # controlling
    audio = $("#audio-player")[0]
    audio.pause()
    audio.currentTime = 0
      
  # update ui
    a = $('.glyphicon-stop')
    a.removeClass('glyphicon-stop')
    a.addClass('glyphicon-play')
  # toggle boolean
    playing = false
  
  startPlayback = ->
          
  # video controlling
    audio = $("#audio-player")[0]
    audio.play()
          
  # Update UI
    a = $('.glyphicon-play')
    a.removeClass('glyphicon-play')
    a.addClass('glyphicon-stop')
          
  # toggle boolean
    playing = true

  $("#play-button").click ->
    if playing
      stopPlayback()
    else
      startPlayback()
    