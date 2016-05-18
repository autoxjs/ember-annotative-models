/*jshint node:true*/
module.exports = function(app) {
  var express = require('express');
  var appsRouter = express.Router();
  var db = require('../ez-db').make('app');

  appsRouter.get('/', function(req, res) {
    res.send({
      data: db.list()
    });
  });

  appsRouter.post('/', function(req, res) {
    var model = db.create(req.body.data);
    res.status(201).send({ data: model });
  });

  appsRouter.get('/:id', function(req, res) {
    res.send({
      data: db.get(req.params.id)
    });
  });

  appsRouter.put('/:id', function(req, res) {
    res.send({
      data: db.update(req.params.id, req.body.data)
    });
  });

  appsRouter.patch('/:id', function(req, res) {
    res.send({
      data: db.update(req.params.id, req.body.data)
    });
  });

  appsRouter.delete('/:id', function(req, res) {
    var model = db.delete(req.params.id);
    res.status(204).send({ data: model });
  });

  // The POST and PUT call will not contain a request body
  // because the body-parser is not included by default.
  // To use req.body, run:

  //    npm install --save-dev body-parser

  // After installing, you need to `use` the body-parser for
  // this mock uncommenting the following line:
  //
  app.use('/api/apps', require('body-parser').json({ type: 'application/*+json' }));
  app.use('/api/apps', appsRouter);
};
