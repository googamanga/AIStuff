// Generated by CoffeeScript 1.6.2
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Brain = (function(_super) {
    __extends(Brain, _super);

    function Brain() {
      _ref = Brain.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Brain.prototype.initialize = function() {
      var error, probability;

      if (arguments.length && arguments[0]['seeFoodConnectionUtility']) {
        try {
          this.set('seeFoodConnectionUtility', [new Variable(arguments[0]['seeFoodConnectionUtility'][0]), new Variable(arguments[0]['seeFoodConnectionUtility'][1])]);
        } catch (_error) {
          error = _error;
          console.log(error, "can't @set seeFoodConnectionUtility inside: ", this);
        }
      } else {
        this.set('seeFoodConnectionUtility', [new Variable(), new Variable()]);
      }
      probability = 1 / this.get('seeFoodConnectionUtility').length;
      this.set('seeFoodConnectionProbabilities', [probability, probability]);
      this.updateProbability();
      return this.set('healthPoints', arguments.length && arguments[0]['healthPoints'] ? arguments[0]['healthPoints'] : 20);
    };

    Brain.prototype.mutate = function() {
      this.get('seeFoodConnectionUtility')[0].mutate();
      this.get('seeFoodConnectionUtility')[1].mutate();
      return this.updateProbability();
    };

    Brain.prototype.updateProbability = function() {
      var minUtil, rawProbAndUtil0, rawProbAndUtil1, sumOfRawProbAndUtil;

      minUtil = Math.min(this.get('seeFoodConnectionUtility')[0].get('d'), this.get('seeFoodConnectionUtility')[1].get('d'));
      rawProbAndUtil0 = this.get('seeFoodConnectionProbabilities')[0] + this.get('seeFoodConnectionUtility')[0].get('d') + (minUtil < 0 ? -minUtil : 0);
      rawProbAndUtil1 = this.get('seeFoodConnectionProbabilities')[1] + this.get('seeFoodConnectionUtility')[1].get('d') + (minUtil < 0 ? -minUtil : 0);
      sumOfRawProbAndUtil = rawProbAndUtil0 + rawProbAndUtil1;
      return this.set('seeFoodConnectionProbabilities', [rawProbAndUtil0 / sumOfRawProbAndUtil, rawProbAndUtil1 / sumOfRawProbAndUtil]);
    };

    Brain.prototype.addHealth = function(num) {
      return this.set('healthPoints', this.get('healthPoints') + num);
    };

    Brain.prototype.subtractHealth = function(num) {
      return this.set('healthPoints', this.get('healthPoints') - num);
    };

    Brain.prototype.act = function() {
      var connectionStrenght, index, rand, sum, _i, _len, _ref1;

      rand = Math.random();
      sum = 0;
      index = 0;
      _ref1 = this.get('seeFoodConnectionProbabilities');
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        connectionStrenght = _ref1[_i];
        sum += connectionStrenght;
        if (sum >= rand) {
          if (index === 0) {
            return 'eat';
          } else {
            return 'do not eat';
          }
        }
        index += 1;
      }
      throw new Error('rand not found in connection Strength array for \'seeFoodConnectionProbabilities\'');
    };

    return Brain;

  })(Backbone.Model);

}).call(this);
