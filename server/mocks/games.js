/*jshint node:true*/
module.exports = function(app) {
  var express = require('express');
  var gamesRouter = express.Router();
  var db = require('../ez-db').make('game');

  gamesRouter.get('/', function(req, res) {
    res.send({
      data: db.list()
    });
  });

  gamesRouter.post('/', function(req, res) {
    var model = db.create(req.body.data);
    res.status(201).send({data: model});
  });

  gamesRouter.get('/:id', function(req, res) {
    res.send({
      data: db.get(req.params.id)
    });
  });

  gamesRouter.put('/:id', function(req, res) {
    res.send({
      data: db.update(req.params.id, req.body.data)
    });
  });

  gamesRouter.patch('/:id', function(req, res) {
    res.send({
      data: db.update(req.params.id, req.body.data)
    });
  });

  gamesRouter.delete('/:id', function(req, res) {
    var model = db.delete(req.params.id);
    res.status(204).send({data: model});
  });

  // The POST and PUT call will not contain a request body
  // because the body-parser is not included by default.
  // To use req.body, run:

  //    npm install --save-dev body-parser

  // After installing, you need to `use` the body-parser for
  // this mock uncommenting the following line:
  //
  app.use('/api/games', require('body-parser').json({ type: 'application/*+json' }));
  app.use('/api/games', gamesRouter);
};
