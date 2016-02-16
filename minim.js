/**
 * Minim-emulation code by Daniel Hodgin
 */

/*
  This is a *VERY* hacky version of minim.js. Do not use for any other project!
*/

var debug = false;

// wrap the P5 Minim sound library classes
function Minim() {
  this.loadFile = function (str, auto) {
    return new AudioPlayer(str, auto);
  }
}

// Browser Audio API
function AudioPlayer(str, auto) {
  var loaded = false;
  var looping = false;

  if (!!document.createElement('audio').canPlayType) {
    var audio = document.createElement('audio');
    audio.addEventListener('ended', function () {
      if (looping) {
        this.currentTime = 0;
        this.play();
      }
    }, false);

  	if (auto != undefined)
  	{
  		console.log("preload: (" + auto + ") " + str);
  		audio.preload = auto;
  	} else {
  		audio.preload = 'none';
  	}

    audio.autobuffer = true;
    if (canPlayOgg() && false) { // No oggs here!
      this.myType = "ogg";
      audio.src = str.split(".")[0] + ".ogg";
    } else if (canPlayWav() && str.split(".")[1] == "wav") {
      this.myType = "wav";
      audio.src = str.split(".")[0] + ".wav";
    } else if (canPlayMp3()) {
      this.myType = "mp3";
      audio.src = str.split(".")[0] + ".mp3";
    }
    loaded = true;
    this.isPlaying = false;

    if (debug)
    {
      // Render the audio divs for debugging purposes.
    	var simplename = str.replace(/\W/g, '');
    	audio.setAttribute("id", simplename);
    	audio.setAttribute("controls", "controls");
      if (document.getElementById("audiocontainer") == null)
      {
        var node = document.createElement("div");
        node.setAttribute("id", "audiocontainer");
      	var currentDiv = document.getElementById("flexbox");
        document.body.insertBefore(node, currentDiv);
      }
      currentDiv = document.getElementById("audiocontainer");
      document.body.insertBefore(audio, currentDiv);
      currentDiv.appendChild(audio);
    }

  }
  this.setGain = function (vol) {
    if (!loaded) {
      return;
    }
  	//if (vol < -20) { vol = -20; }
    var result = Math.pow(10,(vol / 20));
  	audio.volume = result;
  };
  this.play = function () {
    if (!loaded) {
      var local = this;
      setTimeout(function() { local.play(); }, 50);
      return;
    }
//    audio.pause();
    if (this.myType == "mp3")
    {
      if (this.isPlaying)
      {
        audio.play();
      } else {
        audio.currentTime = 0;
      }
    } else {
      audio.currentTime = 0;
      audio.play();
    }
    this.isPlaying = true;
    return;
  };
  this.loop = function () {
    if (!loaded) {
      var local = this;
      setTimeout(function() { local.loop(); }, 50);
      return;
    }
    //audio.loop = 'loop';
    looping = true;
    audio.play();
  };
  this.pause = function () {
    if (!loaded) {
      return;
    }
    this.isPlaying = false;
    audio.pause();
  };
  this.rewind = function () {
    // Rewind screws up things. Urgh.
    if(true)
    {
      return;
    }
    if (!loaded) {
      return;
    }
    // rewind the sound to start
    if(audio.currentTime) {
      audio.currentTime = 0;
    }
  };
  this.position = function() {
    if (!loaded) {
      return -1;
    }
    if(audio.currentTime) {
      return audio.currentTime * 1000;
    }
    return -1;
  };
  this.cue = function(position) {
    if (!loaded) {
      return;
    }
    if(audio.currentTime) {
      audio.currentTime = position / 1000;
    }
  };
  this.mute = function() {
    audio.volume = 0.0;
  };
  this.unmute = function() {
    audio.volume = 1.0;
  };
}

function canPlayOgg() {
  var a = document.createElement('audio');
  return !!(a.canPlayType && a.canPlayType('audio/ogg; codecs="vorbis"').replace(/no/, ''));
}

function canPlayMp3() {
  var a = document.createElement('audio');
  return !!(a.canPlayType && a.canPlayType('audio/mpeg;').replace(/no/, ''));
}

function canPlayWav() {
  var a = document.createElement('audio');
  return !!(a.canPlayType && a.canPlayType(type='audio/wav; codecs="1"').replace(/no/, ''));
}
