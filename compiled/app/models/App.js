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
      this.set('environment', new Environment());
      this.set('judgments', {
        'eat': 5,
        'doNotEat': -5
      });
      this.set('count', 0);
      this.set('intervalId', setInterval(this.mainLoop, 1000 / 60, this));
      return this.set('parentsHealthPointsSum', 0);
    };

    App.prototype.findTheParent = function(wannaBeParents) {
      var agent, index, rand, sum, _i, _len;

      rand = Math.random() * this.get('parentsHealthPointsSum');
      sum = 0;
      index = 0;
      for (_i = 0, _len = wannaBeParents.length; _i < _len; _i++) {
        agent = wannaBeParents[_i];
        sum += agent.get('healthPoints');
        if (sum >= rand) {
          return agent;
        }
        index += 1;
      }
      throw new Error('rand not found in wannaBeParents array');
    };

    App.prototype.mainLoop = function() {
      var deadAgents, luckyOne, wannaBeParents,
        _this = this;

      while (this.get('environment').get('populationLimit') > this.get('environment').get('agents').length) {
        wannaBeParents = this.get('environment').get('agents').filter(function(agent) {
          if (agent.get('wantsABaby')) {
            return _this.set('parentsHealthPointsSum', _this.get('parentsHealthPointsSum') + agent.get('healthPoints'));
          } else {
            return false;
          }
        });
        if (wannaBeParents.length) {
          console.log('wannaBeParents.length', wannaBeParents);
          luckyOne = this.findTheParent(wannaBeParents);
          luckyOne.changeHealth(luckyOne.get('startingHealthPoints') * (-2));
          console.log("the lucky parent is: ", luckyOne, "!");
          console.log("the lucky kid is: ", this.get('environment').spawnAgent(luckyOne.pullEsseceInJSON()).at(this.get('environment').get('agents').length - 1));
        } else {
          this.get('environment').spawnAgent();
        }
        this.set('parentsHealthPointsSum', 0);
      }
      deadAgents = this.get('environment').get('agents').filter(function(agent) {
        if (agent.act() === 'eat') {
          agent.changeHealth(_this.get('judgments').eat);
        } else {
          agent.changeHealth(_this.get('judgments').doNotEat);
        }
        agent.incrimentAge();
        return (agent.get('healthPoints') <= 0) || (agent.get('deathFromOldAge') === true);
      });
      console.log('dead agents length', deadAgents.length);
      if (deadAgents.length) {
        console.log('removing deadAgnets', deadAgents);
      }
      this.get('environment').get('agents').remove(deadAgents);
      this.set('count', this.get('count') + 1);
      console.log('count:', this.get('count'));
      this.get('environment').get('agents').each(function(agent) {
        return console.log('id: ', agent.cid, 'eat%: ', agent.get('linkProbs')[0], 'don\'eat%: ', agent.get('linkProbs')[1], 'healthpoints: ', agent.get('healthPoints'), 'age:', agent.get('age'), 'lastAction: ', agent.get('lastAction'));
      });
      if (this.get('count') >= 100) {
        return clearInterval(this.get('intervalId'));
      }
    };

    return App;

  })(Backbone.Model);

}).call(this);