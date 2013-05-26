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
      this.set('sourceNode');
      this.set('targetNode');
      return this.set('connectionStrength');
    };

    Node.prototype.mutate = function() {
      this.get('position')[0].mutate();
      return this.get('position')[1].mutate();
    };

    return Node;

  })(Backbone.Model);

}).call(this);