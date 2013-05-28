// Generated by CoffeeScript 1.6.2
(function() {
  var _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.App = (function(_super) {
    __extends(App, _super);

    function App() {
      this.mainLoop = __bind(this.mainLoop, this);      _ref = App.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    App.prototype.initialize = function() {
      this.set('env', new Environment());
      this.set('judgments', {
        'eat': 5,
        'doNotEat': -5
      });
      this.set('count', 0);
      debugger;
      this.set('intervalId', setInterval(this.mainLoop, 1000 / 60, this));
      return this.set('momsHealthPointsSum', 0);
    };

    App.prototype.findTheMom = function(wannaBeMoms) {
      var agent, index, rand, sum, _i, _len;

      rand = Math.random() * this.get('momsHealthPointsSum');
      sum = 0;
      index = 0;
      for (_i = 0, _len = wannaBeMoms.length; _i < _len; _i++) {
        agent = wannaBeMoms[_i];
        sum += agent.get('healthPoints');
        if (sum >= rand) {
          return agent;
        }
        index += 1;
      }
      throw new Error('rand not found in wannaBeMoms array');
    };

    App.prototype.mainLoop = function() {
      var deadAgents, luckyOne, wannaBeMoms,
        _this = this;

      while (this.get('env').get('populationLimit') > this.get('env').get('agents').length) {
        wannaBeMoms = this.get('env').get('agents').filter(function(agent) {
          if (agent.get('wantsABaby')) {
            return _this.set('momsHealthPointsSum', _this.get('momsHealthPointsSum') + agent.get('healthPoints'));
          } else {
            return false;
          }
        });
        if (wannaBeMoms.length) {
          console.log('wannaBeMoms.length', wannaBeMoms);
          luckyOne = this.findTheMom(wannaBeMoms);
          luckyOne.changeHealth(luckyOne.get('startingHealthPoints') * (-2));
          this.get('env').spawnAgent(luckyOne.pullEsseceInJSON());
          console.log('*************************************a new baby! the lucky mom is:', luckyOne, "!");
        } else {
          this.get('env').spawnAgent();
        }
        this.set('momsHealthPointsSum', 0);
      }
      deadAgents = this.get('env').get('agents').filter(function(agent) {
        if (agent.act() === 'eat') {
          agent.changeHealth(_this.get('judgments').eat);
        } else {
          agent.changeHealth(_this.get('judgments').doNotEat);
        }
        return agent.get('healthPoints') <= 0;
      });
      console.log('dead agents length', deadAgents.length);
      if (deadAgents.length) {
        console.log('removing deadAgnets', deadAgents);
      }
      this.get('env').get('agents').remove(deadAgents);
      this.set('count', this.get('count') + 1);
      console.log('count:', this.get('count'), 'agents:', this.get('env').get('agents'));
      if (this.get('count') >= 10000) {
        return clearInterval(this.get('intervalId'));
      }
    };

    return App;

  })(Backbone.Model);

}).call(this);
