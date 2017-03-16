// Grab elements, create settings, etc.

// Get access to the camera!
navigator.getMedia = ( navigator.getUserMedia || // use the proper vendor prefix
                       navigator.webkitGetUserMedia ||
                       navigator.mozGetUserMedia ||
                       navigator.msGetUserMedia);

function load() {
  var video = document.getElementById('video-frame');
  var captureCanvas = document.getElementById('capture-frame');
  var captureButton = document.getElementById('capture-button');
  var hexDigest = document.getElementById('hex-digest');

  var fillCanvasWithImage = function(img, canvas) {
    var context = canvas.getContext('2d');
    context.drawImage(img, 0, 0, canvas.width, canvas.height);
  }

  var initCanvasDummy = function() {
    var img = new Image();

    img.onload = function() {
      fillCanvasWithImage(img, captureCanvas);
    };

    img.crossOrigin = "anonymous";
    img.src = "http://i.imgur.com/XmyYZ0v.jpg";
  }

  var showCameraStream = function(stream) {
    video.src = window.URL.createObjectURL(stream);
    video.play();
  };

  var showDummyVideo = function() {
    video.src = "http://i.imgur.com/YONXnLX.mp4";
    video.loop = true;
  }

  var onClickVisionAuthentication = function() {
    fillCanvasWithImage(video, captureCanvas);
    var dataURL = captureCanvas.toDataURL('image/png');

    $.post('/login', {
      session: {
        user_image: dataURL
      }
    }, function(data, status) {
      if(data['success'] == false) {
        if(hexDigest.style["display"] === "none") {
          hexDigest.style["display"] = "block";
        }
        hexDigest.innerText = data['error'];
      }
    });
  }

  initCanvasDummy();
  captureButton.addEventListener('click', onClickVisionAuthentication);
  navigator.getMedia({video: true}, showCameraStream, showDummyVideo);
}

$(document).ready(load);
