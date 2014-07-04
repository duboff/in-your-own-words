window['after_signup#show'] = (data) ->
  $(document).ready ->
    $('#allowMessage').modal('show')
    if window.location.pathname.split("/")[2] == 'record_audio'
      record()

  record = ->
    stream = undefined
    audio_recorder = null
    recording = false
    playing = false
    formData = null
    
    # record the audio

    # start recording
    navigator.getUserMedia
      audio: true
      video: false
    , ((stream) ->
      audio_recorder = RecordRTC(stream,
        type: "audio"
        bufferSize: 16384
      )
    
    # # update UI
      hideReminder()
    ), ->
      
    hideReminder = ->
      $('#allowMessage').modal('hide')

    startRecording = ->
      # record the audio and video
      audio_recorder.startRecording()
      
      # update the UI
      # $("#play_button").hide()
      # $("#upload_button").hide()
      $("audio.recorder").show()

      a = $('.glyphicon-record')
      a.removeClass('glyphicon-record')
      a.addClass('glyphicon-stop')

      # $("#audio-player").remove()
      
      # toggle boolean
      recording = true

    stopRecording = ->
      
      # stop recorders
      audio_recorder.stopRecording()
      
      # set form data
      formData = new FormData()
      audio_blob = audio_recorder.getBlob()
      formData.append "audio", audio_blob
      
      # add players
      audio_player = document.createElement("audio")
      audio_player.id = "audio-player"
      audio_player.src = URL.createObjectURL(audio_blob)
      audio_player.controls = true
      $("#players").append audio_player
      
      # update UI
      # $("video.recorder").hide();
      # $("#play_button").show()
      $("#upload_button").show()
      $("#record_button").text "Start recording"

      a = $('.glyphicon-stop')
      a.removeClass('glyphicon-stop')
      a.addClass('glyphicon-play')
      
      # toggle boolean
      recording = false
    
    # handle recording
    
    $("#record-button").click ->
      if recording
        stopRecording()
      else
        startRecording()

    # stop playback
    # stopPlayback = ->
      
    #   # controlling
    #   audio = $("#audio-player")[0]
    #   audio.pause()
    #   audio.currentTime = 0
      
    #   # update ui
    #   # $("#play_button").text "Play"
      
    #   # toggle boolean
    #   playing = false
    
    # # start playback
    # startPlayback = ->
      
    #   # video controlling
    #   audio = $("#audio-player")[0]
    #   audio.play()
      
    #   # Update UI
    #   # $("#play_button").text "Stop"
      
    #   # toggle boolean
    #   playing = true
    
    # handle playback
    # $("#play_button").click ->
    #   if playing
    #     stopPlayback()
    #   else
    #     startPlayback()
    #   return
    
    # Upload button
    $("#upload_button").click ->
      request = new XMLHttpRequest()
      # id = window.location.pathname.split("/")[2]
      
      # request.onreadystatechange = function() {
      #     if (request.readyState == 4 && request.status == 200) {
      #         window.location.href = "/video/" + request.responseText;
      #     }
      # };
      request.open "POST", "upload"
      request.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
      request.send formData


