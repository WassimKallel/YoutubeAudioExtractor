// Call a native method 'ScreenBrightness'
Mobile('ScreenBrightness').call(function(br){
  console.log("Screen Brightness", br);
});

var http = require('http');
var ytdl = require('ytdl-core');

var directUrl = "";

// Register method so we can call it from native side
Mobile('UpdateLink').register(function(link){
  getAudioUrl(link);
});


var os = require('os');
var nis = os.networkInterfaces();

var arrIP = [];
for (var o in nis) {
  if (!nis.hasOwnProperty(o)) continue;
  
  var interfaces = nis[o];
  
  for(var o in interfaces) {
    if (interfaces[o].family == "IPv4" && interfaces[o].address != "127.0.0.1"
              && interfaces[o].address.length) {
      arrIP.push(interfaces[o].address);
    }
  }
}

// calling a native method but
// we don't know the number of arguments
// Use function.apply
var ipset = Mobile('SetIPAddress');
ipset.call.apply(ipset, arrIP);



http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.write(directUrl);
  res.end();
  directUrl = "";
}).listen(3000);




console.log('Server running at (port:3000) ' + arrIP);


function getAudioUrl(youtubeVideoUrl) {
    ytdl.getInfo(youtubeVideoUrl, null , function(err, info) {
        for(var index in info.formats) {
             var format = info.formats[index];
             if (format.resolution == null && format.container == "mp4") {
                  directUrl = format.url;
             }
        }
    })
}

