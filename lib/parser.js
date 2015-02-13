var xslt = require('node_xslt');
var jsdom = require('jsdom');
var fs = require('fs');
var jquery = fs.readFileSync(__dirname + '/../bower_components/jquery/dist/jquery.js', 'utf-8');
var ejs = require('ejs');

exports.parse = function(dirPath, callback) {
  var data = { config: require(dirPath + '/config.json') };
      stylesheet,
      document,
      htmlDocument;

  data = {};
  data.config = require(dirPath + '/config.json');

  htmlDocument = xslt.transform(stylesheet, document, []);

  jsdom.env({
    html: htmlDocument,
    src: jquery,
    done: function(errors, window) {
      var $ = window.$;
      callback($('html').html());
    }
  });
};

var parseStylesheet = function() {
  stylesheet = fs.readFileSync(__dirname + '/../template.xsl').toString();
  stylesheet = ejs.render(stylesheet, data);
  stylesheet = xslt.readXsltString(stylesheet);
};


var parseXml = function() {
  document = fs.readFileSync(dirPath + '/email.xml').toString();
  document = ejs.render(document, data, {filename: dirPath + '/email.xml'});
  document = xslt.readXmlString(document);
};

var setImagesSize = function($) {
    $('img').each(function() {
      // $(this).attr('width', '200');
      // $(this).attr('height', '200');
    });
};
