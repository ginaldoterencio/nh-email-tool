var connect = require('connect');
var livereload = require('livereload');
var http = require('http');
var serveStatic = require('serve-static');
var parser = require('./parser');

exports.server = function(dirPath, options, callback) {
  var app = connect();

  app.use(serveStatic(dirPath));

  app.use('/', function(req, res) {
    parser.parse(dirPath, function(html) {
      res.end(html);
    });
  });

  var httpServer = http.createServer(app);
  httpServer.listen(8888);

  var server = livereload.createServer({});
  server.watch(dirPath);
};
