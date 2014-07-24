window['after_signup#show'] = (data) ->
  $(document).ready ->
    
    
    if window.location.pathname.split("/")[2] == 'record_audio'
      $('#allowMessage').modal('show')
      record()

  record = ->
    stream = undefined
    audio_recorder = null
    recording = false
    formData = null
    audio_player = $('#audio-player')[0]
    
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
      hideReminder()
    ), ->
      
    hideReminder = ->
      $('#allowMessage').modal('hide')

    startRecording = ->
    # record the audio and video
      audio_recorder.startRecording()
      
    # update the UI
      a = $('.glyphicon-record')
      a.removeClass('glyphicon-record')
      a.addClass('glyphicon-stop')
      
    # toggle boolean
      recording = true
      
    stopRecording = ->
      
    # stop recorders
      audio_recorder.stopRecording (audioURL) ->
        audio_player.src = audioURL
      
    # set form data
        formData = new FormData()
        audio_blob = audio_recorder.getBlob()
        formData.append "audio", audio_blob

    # update UI
      $("#record-button").hide()
      $('#play-button').removeClass('hidden')
      $(".links").show()
      $(".explainer").hide()
      $("#skip-audio-link").hide()
      
    # toggle boolean
      recording = false
    
    # handle recording
    
    $("#record-button").click ->
      if recording
        stopRecording()
      else
        startRecording()      
        setTimeout (->
          stopRecording() if recording
        ), 60000 # 1 minute maximum for recording
    
    # Upload button
    $("#upload-link").click (e) ->
      e.preventDefault()
      request = new XMLHttpRequest()
       # id = window.location.pathname.split("/")[2]
      
      request.onreadystatechange = ->
        if request.readyState == 4 and request.status == 200
          $('fa-spinner').addClass('hidden')
          window.location.href = $("#upload-link").attr('href');
      request.upload.onprogress = ->
        $('.fa-spinner').removeClass('hidden')
        $(".links").addClass('hidden')

      request.open "POST", "upload"
      request.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
      request.send formData
    
    $("#cancel-link").click ->
      $(".links").hide()
      $(".explainer").show()
      $("#skip-audio-link").show()
      $("#record-button").show()
      $('#play-button').addClass('hidden')
      a = $('#record-button').find('.glyphicon-stop')
      a.removeClass('glyphicon-stop')
      a.addClass('glyphicon-record')
      