var _ = require("lodash");

function ezDB(modelName) {
  this.modelName = modelName;
  this.storage = [];
}

ezDB.prototype.create = function(data) {
  data.id = this.storage.length;
  this.storage.push(data);
  return data;
}

ezDB.prototype.update = function(id, data) {
  _.merge(this.storage[id], data);
  return this.storage[id];
}

ezDB.prototype.get = function(id) {
  return this.storage[id];
}

ezDB.prototype.list = function() {
  return _.filter(this.storage, _.isObject);
}

ezDB.prototype.delete = function(id) {
  var data = this.storage[i];
  this.storage[i] = null;
  return data;
}

module.exports = {
  make: function(modelName) {
    return new ezDB(modelName);
  }
}
