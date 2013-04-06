{ok:expect, equal} = require 'assert'
Quack = require './index'

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

  it 'supports beforeEach'
  it 'supports afterEach'
  it 'supports after (current test)'
  it 'supports async tests with `done`'
  it 'maintains a relevant test context'

