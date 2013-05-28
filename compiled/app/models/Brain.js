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
      var connectionSum, error, probability;

      if (arguments.length && arguments[0]['linkUtil']) {
        try {
          this.set('linkUtil', [new Variable(arguments[0]['linkUtil'][0]), new Variable(arguments[0]['linkUtil'][1])]);
        } catch (_error) {
          error = _error;
          console.log(error, "can't @set linkUtil inside: ", this);
        }
      } else {
        this.set('linkUtil', [new Variable(), new Variable()]);
      }
      if (arguments.length && arguments[0]['linkProbs']) {
        this.set('linkProbs', [arguments[0]['linkProbs'][0], arguments[0]['linkProbs'][1]]);
        connectionSum = arguments[0]['linkProbs'].reduce(function(memo, connection) {
          return memo + connection;
        });
        try {
          if ((1.0000000000000001 < connectionSum && connectionSum < 0.9999999999999999)) {
            throw new Error;
          }
        } catch (_error) {
          error = _error;
          console.log(error, "can't @set linkProbs inside: ", this, "sum is: ", connectionSum);
        }
      } else {
        probability = 1 / this.get('linkUtil').length;
        this.set('linkProbs', [probability, probability]);
      }
      this.set('startingHealthPoints', 20);
      this.set('healthPoints', this.get('startingHealthPoints'));
      this.set('wantsABaby', false);
      this.set('lastAction', null);
      return this.mutate();
    };

    Brain.prototype.mutate = function() {
      this.get('linkUtil')[0].mutate();
      this.get('linkUtil')[1].mutate();
      return this.updateProbability();
    };

    Brain.prototype.updateProbability = function() {
      var minUtil, rawProbAndUtil0, rawProbAndUtil1, sumOfRawProbAndUtil;

      minUtil = Math.min(this.get('linkUtil')[0].get('d'), this.get('linkUtil')[1].get('d'));
      rawProbAndUtil0 = this.get('linkProbs')[0] + this.get('linkUtil')[0].get('d') + (minUtil < 0 ? -minUtil : 0);
      rawProbAndUtil1 = this.get('linkProbs')[1] + this.get('linkUtil')[1].get('d') + (minUtil < 0 ? -minUtil : 0);
      sumOfRawProbAndUtil = rawProbAndUtil0 + rawProbAndUtil1;
      return this.set('linkProbs', [rawProbAndUtil0 / sumOfRawProbAndUtil, rawProbAndUtil1 / sumOfRawProbAndUtil]);
    };

    Brain.prototype.changeHealth = function(num) {
      this.set('healthPoints', this.get('healthPoints') + num);
      return this.set('wantsABaby', this.get('healthPoints') >= (3 * this.get('startingHealthPoints')) ? true : false);
    };

    Brain.prototype.pullEsseceInJSON = function() {
      return JSON.stringify(this);
    };

    Brain.prototype.act = function() {
      var action, connectionStrenght, index, rand, sum, _i, _len, _ref1;

      rand = Math.random();
      sum = 0;
      index = 0;
      this.mutate();
      _ref1 = this.get('linkProbs');
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        connectionStrenght = _ref1[_i];
        sum += connectionStrenght;
        if (sum >= rand) {
          action = index === 0 ? 'eat' : 'do not eat';
          this.set('lastAction', action);
          return action;
        }
        index += 1;
      }
      throw new Error('rand not found in connection Strength array for \'linkProbs\'');
    };

    return Brain;

  })(Backbone.Model);

}).call(this);
