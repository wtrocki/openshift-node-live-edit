var express = require("express");
var message = require("./lib/message");
var app = express();

app.get('/', function(req, res){
  res.send(message);
});

if (!module.parent) {
  app.listen(8080);
  console.log('Express started on port 8080');
}