module.exports = class Quack
  constructor: ->
    @results =
      total: 0
      passed: 0
      failed: 0
      status: 'fail'

    @tests = []

  run: (callback) ->
    @runTests()
    callback(@results)

  it: (description, method) ->
    @tests.push({description, method})

  runTests: ->
    for test in @tests
      try
        test.method()
        @results.passed += 1
      catch e
        @results.failed += 1

    @results.total = @tests.length

    if @results.failed > 0 || @results.total == 0
      @results.status = 'fail'
    else
      @results.status = 'pass'

