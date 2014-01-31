var express = require('express');
var colors = require('colors');
var request = require('request');
var _ = require('lodash');
var WebSocketServer = require('ws').Server;

var app = express();
var wss = new WebSocketServer({
  port: 8080
});

console.log('Socket server created', JSON.stringify(wss, null, 2));

wss.on('connection', function (ws) {
  var message = 'CONNECTED: ';
  console.log(message.green);
  var syncToken = 'first_token';
  ws.on('message', function (data, flags) {
    var message1 = 'MESSAGE_RECEIVED:' + JSON.stringify(data, null, 2);
    console.log(message1.blue);
    setInterval(function () {
      console.log('function called on timeout, sending message'.red);
      if (ws.readyState == ws.OPEN) {
        request({
          url: 'whatever url you want to add in',
          auth: {
            username: '<your username comes here>',
            password: '<your password comes here>'
          }
        }, function(err, response, body) {
          console.log('ERROR:' + JSON.stringify(err, null, 2).red);
          console.log('BODY:' + JSON.stringify(body, null, 2).blue);
          console.log('RESPONSE:' + response.statusCode);
          if (body) {
            var parsedBody = JSON.parse(body);
            if (parsedBody.errors) {
              syncToken = parsedBody.errors[0].sync;
              console.log('received sync token:' + syncToken );
            } else {
              syncToken = parsedBody.sync;
              if (parsedBody.data.length) {
                _.each(parsedBody.data, function (element) {
                  var finalMessage = '';
                  console.log('ELEMENT:' + element);
                  if (element.user && element.user.name) {
                    finalMessage += (element.user.name + ' ');
                  }
                  if (element.type) {
                    finalMessage += element.type + ' ';
                  }
                  if (element.resource && element.resource.name) {
                    finalMessage += (element.resource.name + ' ');
                  }
                  if (element.resource && element.resource.text) {
                    finalMessage += (element.resource.text + ' ');
                  }
                  console.log('FINAL_MESSAGE:' + finalMessage.yellow);
                  ws.send(finalMessage);
                });
              }
            }
          }
        });
      }
    }, 6500);
  });

  ws.on('close', function (ws) {
    var message2 = 'CLOSED:';
  });
});

app.get('/events', function(req, res) {
    res.type('application/json');
    res.send({
      hello: {
        world: 'inner string'
      }
    });
});

app.listen(5000);

