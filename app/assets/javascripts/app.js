$(document).ready(function() {

    // setup
    var stream;
    var audio_recorder = null;
    var recording = false;
    var playing = false;
    var formData = null;


    // record the audio
    navigator.getUserMedia({
        audio: true,
        video: false
    }, function(stream) {
        audio_recorder = RecordRTC(stream, {
            type: "audio",
            bufferSize: 16384
        });
        // update UI
        $("#record_button").show();
    }, function() {

    });
    // start recording
    var startRecording = function() {
        // record the audio and video
        audio_recorder.startRecording();

        // update the UI
        $("#play_button").hide();
        $("#upload_button").hide();
        $("audio.recorder").show();
        // $("#video-player").remove();
        $("#audio-player").remove();
        $("#record_button").text("Stop recording");

        // toggle boolean
        recording = true;
    }
    var stopRecording = function() {
        // stop recorders
        audio_recorder.stopRecording();

        // set form data
        formData = new FormData();

        var audio_blob = audio_recorder.getBlob();
        formData.append("audio", audio_blob);

        // add players
        var audio_player = document.createElement("audio");
        audio_player.id = "audio-player";
        audio_player.src = URL.createObjectURL(audio_blob);
        $("#players").append(audio_player);


        // update UI
        // $("video.recorder").hide();
        $("#play_button").show();
        $("#upload_button").show();
        $("#record_button").text("Start recording");

        // toggle boolean
        recording = false;
    }
    // handle recording
    $("#record_button").click(function() {
        if (recording) {
            stopRecording();
        } else {
            startRecording();
        }
    });
    // stop playback
    var stopPlayback = function() {
        // controlling
        audio = $("#audio-player")[0];
        audio.pause();
        audio.currentTime = 0;

        // update ui
        $("#play_button").text("Play");

        // toggle boolean
        playing = false;
    }

    // start playback
    var startPlayback = function() {
        // video controlling

        audio = $("#audio-player")[0];
        audio.play();

        // Update UI
        $("#play_button").text("Stop");

        // toggle boolean
        playing = true;
    }
    // handle playback
    $("#play_button").click(function() {
        if (playing) {
            stopPlayback();
        } else {
            startPlayback();
        }
    });
    // Upload button
    $("#upload_button").click(function() {
        var request = new XMLHttpRequest();


        // request.onreadystatechange = function() {
        //     if (request.readyState == 4 && request.status == 200) {
        //         window.location.href = "/video/" + request.responseText;
        //     }
        // };

        request.open('POST', "8/upload");
        request.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        request.send(formData);
    });

});