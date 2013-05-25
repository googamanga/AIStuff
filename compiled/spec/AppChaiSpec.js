// Generated by CoffeeScript 1.6.2
(function() {
  var assert, expect, should;

  assert = chai.assert;

  expect = chai.expect;

  should = chai.should();

  describe('variable', function() {
    var variable;

    variable = null;
    beforeEach(function() {
      return variable = new Variable();
    });
    afterEach(function() {
      return variable = null;
    });
    it("should create a varable correctly", function() {
      expect(variable).to.exist;
      expect(variable.get('c')).to.equal(1e-7);
      expect(variable.get('a')).to.equal(0.0001);
      expect(variable.get('v')).to.equal(0.01);
      return expect(variable.get('d')).to.equal(1);
    });
    it("should create a varable correctly when overriding defaults", function() {
      var variable1;

      variable1 = new Variable({
        'd': 4,
        'v': 3,
        'a': 2,
        'c': 1
      });
      expect(variable1.get('c')).to.equal(1);
      expect(variable1.get('a')).to.equal(2);
      expect(variable1.get('v')).to.equal(3);
      return expect(variable1.get('d')).to.equal(4);
    });
    return it("should mutate a varable correctly", function() {
      expect(variable.mutate).to.exist;
      expect(variable.get('c')).to.equal(1e-7);
      expect(variable.get('a')).to.equal(0.0001);
      expect(variable.get('v')).to.equal(0.01);
      expect(variable.get('d')).to.equal(1);
      variable.mutate();
      expect(variable.get('a')).is.above(0.0001 - 1e-7 / 2).and.below(0.0001 + 1e-7 / 2).and.is.not.equal(0.0001);
      expect(variable.get('v')).is.above(0.01 - 0.0001 / 2).and.below(0.01 + 0.0001 / 2).and.is.not.equal(0.01);
      return expect(variable.get('d')).is.above(1 - 0.01 / 2).and.below(1 + 0.01 / 2).and.is.not.equal(1);
    });
  });

  describe("node", function() {
    var node;

    node = null;
    beforeEach(function() {
      return node = new Node();
    });
    afterEach(function() {
      return node = null;
    });
    it("should be defined when created", function() {
      expect(node).to.exist;
      expect(node.get('position')).to.exist;
      return expect(node.get('type')).to.exist;
    });
    it("should be initialized", function() {
      node.get('position')[0].mutate();
      node.get('position')[1].mutate();
      node.get('position')[0].get('d');
      expect(node.get('position')[0].get('d')).is.above(1 - 0.01 / 2).and.below(1 + 0.01 / 2).and.is.not.equal(1);
      expect(node.get('position')[1].get('d')).is.above(1 - 0.01 / 2).and.below(1 + 0.01 / 2).and.is.not.equal(1);
      return expect(node.get('type')).to.equal('regular');
    });
    it("should update position with parameters", function() {
      var node1;

      node1 = new Node({
        'position': [
          new Variable({
            'd': 5,
            'v': 3
          }), new Variable({
            'd': 3
          })
        ]
      });
      node1.get('position')[0].mutate();
      node1.get('position')[1].mutate();
      expect(node1.get('position')[0].get('d')).is.above(5 - 3 / 2).and.below(5 + 3 / 2).and.is.not.equal(5);
      return expect(node1.get('position')[1].get('d')).is.above(3 - 0.01 / 2).and.below(3 + 0.01 / 2).and.is.not.equal(3);
    });
    it("should update type with parameter", function() {
      var node1;

      node1 = new Node({
        'type': 'sensor'
      });
      return expect(node1.get('type')).to.equal('sensor');
    });
    return it("should mutate position variables using node.mutate", function() {
      expect(node.get('position')[0].get('d')).is.equal(1);
      expect(node.get('position')[1].get('d')).is.equal(1);
      node.mutate();
      expect(node.get('position')[0].get('d')).is.above(1 - 0.01 / 2).and.below(1 + 0.01 / 2).and.is.not.equal(1);
      return expect(node.get('position')[1].get('d')).is.above(1 - 0.01 / 2).and.below(1 + 0.01 / 2).and.is.not.equal(1);
    });
  });

  describe("nodes", function() {
    var nodes;

    nodes = null;
    beforeEach(function() {
      return nodes = new Nodes();
    });
    afterEach(function() {
      return nodes = null;
    });
    it("should be defined when created", function() {
      expect(nodes).to.exist;
      return expect(nodes.length).to.exist;
    });
    it("should be able to add default", function() {
      expect(nodes.add({}).length).to.equal(1);
      expect(nodes.at(0).get('position')[1].get('d')).is.equal(1);
      return expect(nodes.at(0).get('type')).is.equal('regular');
    });
    return it("should be able to add several non-default nodes", function() {
      nodes.add([
        {}, {
          'type': 'sensor'
        }
      ]);
      expect(nodes.length).is.equal(2);
      return expect(nodes.at(1).get('type')).is.equal('sensor');
    });
  });

}).call(this);
