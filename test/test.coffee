{ok:expect, equal} = require 'assert'
Quack = require '../src/index'

# We're using mocha to test our test framework.
# Any global describe/it methods are from mocha.
# Any describe/it methods called on a quack instance
# are part of the framework under test.

describe 'quack engine', ->

  it 'fails on empty run', ->
    duck = new Quack
    duck.run (results) ->
      equal results.total, 0
      equal results.passed, 0
      equal results.failed, 0
      equal results.status, 'fail'

  it 'can set up specs', ->
    duck = new Quack
    duck.it 'blank passing test', ->

    duck.run (results) ->
      equal results.total, 1
      equal results.passed, 1
      equal results.failed, 0
      equal results.status, 'pass'

  it 'can set up failing specs', ->
    duck = new Quack
    duck.it 'failing test', ->
      throw new Error

    duck.run (results) ->
      equal results.total, 1, 'total'
      equal results.passed, 0, 'passed'
      equal results.failed, 1, 'failed'
      equal results.status, 'fail', 'status'

  it 'supports desrcibe blocks', ->
    duck = new Quack
    duck.describe 'describe block', ->
      duck.it 'blank passing test', ->

    duck.run (results) ->
      equal results.total, 1, 'total'
      equal results.passed, 1, 'passed'
      equal results.failed, 0, 'failed'
      equal results.status, 'pass', 'status'

  it 'supports beforeEach', ->
    duck = new Quack
    beforeEachCalled = false
    duck.describe 'describe block', ->
      duck.beforeEach ->
        beforeEachCalled = true
      duck.it 'test', ->
        expect beforeEachCalled

    duck.run (results) ->
      equal results.total, 1, 'total'
      equal results.passed, 1, 'passed'
      equal results.failed, 0, 'failed'
      equal results.status, 'pass', 'status'

  it 'supports afterEach', ->
    duck = new Quack
    afterEachCalled = false
    duck.describe 'describe block', ->
      duck.afterEach ->
        afterEachCalled = true
      duck.it 'test', ->
        equal afterEachCalled, false
      duck.it 'second test', ->
        equal afterEachCalled, true

    duck.run (results) ->
      equal results.total, 2, 'total'
      equal results.passed, 2, 'passed'
      equal results.failed, 0, 'failed'
      equal results.status, 'pass', 'status'

  it 'maintains a relevant test context', ->
    duck = new Quack
    duck.describe 'describe block', ->
      duck.beforeEach ->
        @beforeEachCalled = true
      duck.it 'test', ->
        expect @beforeEachCalled

    duck.run (results) ->
      equal results.total, 1, 'total'
      equal results.passed, 1, 'passed'
      equal results.failed, 0, 'failed'
      equal results.status, 'pass', 'status'

  it 'supports nesting'
  it 'supports after (current test)'
  it 'supports async tests with `done`'

