// Grab elements, create settings, etc.

// Get access to the camera!
navigator.getMedia = ( navigator.getUserMedia || // use the proper vendor prefix
                       navigator.webkitGetUserMedia ||
                       navigator.mozGetUserMedia ||
                       navigator.msGetUserMedia);

var imageData = "";
var videoStreaming = true;

function load() {
  var videoFrame = document.getElementById('video-frame');
  var captureCanvas = document.getElementById('capture-frame');
  var captureButton = document.getElementById('capture-button');
  var submitButton = document.getElementById('form-submit-button');

  var replaceVideoWithImage = function(img, canvas) {
    var context = canvas.getContext('2d');
    context.drawImage(img, 0, 0, canvas.width, canvas.height);
    videoFrame.style.display = "none";
    captureCanvas.style.display = "block";
  }

  var showCameraStream = function(stream) {
    videoFrame.src = window.URL.createObjectURL(stream);
    videoFrame.play();
  };

  var showDummyVideo = function() {
    videoFrame.src = "http://i.imgur.com/YONXnLX.mp4";
    videoFrame.loop = true;
  }

  var onClickCapture = function() {
    if(videoStreaming) {
      replaceVideoWithImage(videoFrame, captureCanvas);
      imageData = captureCanvas.toDataURL('image/png');
      captureButton.value = "Retake image"
      videoStreaming = false;
    } else {
      videoFrame.style.display = "block";
      captureCanvas.style.display = "none";
      captureButton.value = "Capture image"
      videoStreaming = true;
    }
  }

  var onClickSubmit = function() {
    $('#user_master_image')[0].value = imageData;
    $('form').submit();
  }

  captureButton.addEventListener('click', onClickCapture);
  submitButton.addEventListener('click', onClickSubmit)
  navigator.getMedia({video: true}, showCameraStream, showDummyVideo);
}

$(document).ready(load);
