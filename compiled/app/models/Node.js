// Generated by CoffeeScript 1.6.2
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Node = (function(_super) {
    __extends(Node, _super);

    function Node() {
      _ref = Node.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Node.prototype.initialize = function() {
      this.set({
        'position': arguments.length && arguments[0]['position'] ? arguments[0]['position'] : [new Variable, new Variable]
      });
      return this.set({
        'type': arguments.length && arguments[0]['type'] ? arguments[0]['type'] : 'regular'
      });
    };

    return Node;

  })(Backbone.Model);

}).call(this);
