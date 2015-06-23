module.exports = class Quack
  constructor: ->
    @results =
      total: 0
      passed: 0
      failed: 0
      status: 'fail'

    @tests = []
    @beforeEaches = []
    @afterEaches = []

  run: (callback) ->
    @runTests()
    callback(@results)

  describe: (description, method) ->
    method()

  it: (description, method) ->
    @tests.push({description, method})

  beforeEach: (method) ->
    @beforeEaches.push(method)

  afterEach: (method) ->
    @afterEaches.push(method)

  runTests: ->

    for test in @tests
      testContext = {}

      for beforeEach in @beforeEaches
        try
          beforeEach.call(testContext)
        catch error
          console.error(error.stack)
          # stop test suite

      try
        test.method.call(testContext)
        @results.passed += 1
      catch e
        @results.failed += 1

      for afterEach in @afterEaches
        try
          afterEach.call(testContext)
        catch error
          console.error(error.stack)

    @results.total = @tests.length

    if @results.failed > 0 || @results.total == 0
      @results.status = 'fail'
    else
      @results.status = 'pass'

