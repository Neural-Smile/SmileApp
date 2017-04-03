// Grab elements, create settings, etc.

// Get access to the camera!
navigator.getMedia = ( navigator.getUserMedia || // use the proper vendor prefix
                       navigator.webkitGetUserMedia ||
                       navigator.mozGetUserMedia ||
                       navigator.msGetUserMedia);

var imageData = "";
var masterImage = "";
var videoStreaming = true;
var trainingImages = [];

function load() {
  var videoFrame = document.getElementById('video-frame');
  var captureCanvas = document.getElementById('capture-frame');
  var captureButton = document.getElementById('capture-button');
  var submitButton = document.getElementById('form-submit-button');

  var putFrameIntoCanvas = function(img, canvas) {
    var context = canvas.getContext('2d');
    context.drawImage(img, 0, 0, canvas.width, canvas.height);
  }

  var replaceVideoWithImage = function(img, canvas) {
    putFrameIntoCanvas(img, canvas);
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
    putFrameIntoCanvas(videoFrame, captureCanvas);
    if (masterImage != "") {
      trainingImages.push(captureCanvas.toDataURL('image/png'));
      captureButton.value = "Images taken: " + trainingImages.length + ". Keep going";
    } else {
      masterImage = captureCanvas.toDataURL('image/png');
      captureButton.value = "Master image taken. Keep going to take training images";
    }
  }

  var onClickSubmit = function() {
    $('#user_master_image')[0].value = masterImage;
    $('#user_training_images')[0].value = trainingImages;
    $('form').submit();
  }

  captureButton.addEventListener('click', onClickCapture);
  submitButton.addEventListener('click', onClickSubmit)
  navigator.getMedia({video: true}, showCameraStream, showDummyVideo);
}

$(document).ready(load);
