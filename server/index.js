const express = require('express');
const app = express();
const expressWS = require('express-ws');
const port = 3000;

// initialize app for web sockets
expressWS(app);

// listen on port
app.listen(port, function() {
  console.log(`Listening on port ${port}`);
});

app.ws('/', function(socket) {
  console.log('New client connected.');

  socket.on('message', function(message) {
    console.log(`A client sent a message: ${message}`);
    socket.send('Hello, world!');
  });
});
