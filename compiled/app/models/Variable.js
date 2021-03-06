// Generated by CoffeeScript 1.6.2
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Variable = (function(_super) {
    __extends(Variable, _super);

    function Variable() {
      _ref = Variable.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Variable.prototype.initialize = function() {
      this.set('c', arguments.length && arguments[0]['c'] ? arguments[0]['c'] : 0.0000001);
      this.set('a', arguments.length && arguments[0]['a'] ? arguments[0]['a'] : 0.0001);
      this.set('v', arguments.length && arguments[0]['v'] ? arguments[0]['v'] : 0.01);
      this.set('d', arguments.length && arguments[0]['d'] ? arguments[0]['d'] : 1);
      return this.mutate();
    };

    Variable.prototype.mutate = function(distance, velocity, accelerate, constant) {
      this.set('a', accelerate ? accelerate - (this.get('c')) / 2 + Math.random() * (this.get('c')) : (this.get('a')) - (this.get('c')) / 2 + Math.random() * (this.get('c')));
      this.set('v', velocity ? velocity - this.get('a' / 2 + Math.random() * this.get('a')) : (this.get('v')) - (this.get('a')) / 2 + Math.random() * (this.get('a')));
      return this.set('d', distance ? distance - this.get('v' / 2 + Math.random() * this.get('v')) : (this.get('d')) - (this.get('v')) / 2 + Math.random() * (this.get('v')));
    };

    return Variable;

  })(Backbone.Model);

}).call(this);
