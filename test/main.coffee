swear = require '../'
should = require 'should'
require 'mocha'

describe 'swear', ->
  describe 'create', ->
    it 'should create a new promise', (done) ->
      should.exist swear()
      done()

  describe 'when()', ->
    it 'should call with no data', (done) ->
      p = swear()
      p.when done
      p.resolve()

    it 'should call', (done) ->
      p = swear()
      e = [1,2,3]
      p.when (g...) ->
        g.should.eql e
        done()
      p.resolve e...

    it 'should call after resolved', (done) ->
      p = swear()
      e = [1,2,3]
      p.resolve e...
      p.when (g...) ->
        g.should.eql e
        done()

    it 'should not call on abort', (done) ->
      p = swear()
      p.when -> throw "fak"
      p.abort()
      done()

  describe 'fail()', ->
    it 'should call with no error', (done) ->
      p = swear()
      p.fail done
      p.abort()

    it 'should call', (done) ->
      p = swear()
      p.fail (g) ->
        g.should.eql 1
        done()
      p.abort 1

    it 'should call after resolved', (done) ->
      p = swear()
      p.abort 1
      p.fail (g) ->
        g.should.eql 1
        done()

    it 'should not call on resolve', (done) ->
      p = swear()
      p.fail -> throw "fak"
      p.resolve 1
      done()

  describe 'wrap()', ->
    it 'should call resolve with data', (done) ->
      p = swear()
      async = (cb) -> cb null, 1, 2
      async p.wrap()
      p.fail -> throw "fak"
      p.when (a...) -> 
        a.should.eql [1,2]
        done()

    it 'should call abort with error', (done) ->
      p = swear()
      async = (cb) -> cb 1, 2, 3
      async p.wrap()
      p.fail (a) -> 
        a.should.eql 1
        done()
      p.when -> throw "fak"

  describe 'join()', ->
    it 'should complete with success', (done) ->
      p = swear()
      p2 = swear()
      p3 = swear.join p, p2
      
      p3.when (a,b) ->
        a.should.eql [1,2,3]
        b.should.eql [4,5,6]
        done()
      p2.resolve 1,2,3
      p.resolve 4,5,6

    it 'should complete with error', (done) ->
      p = swear()
      p2 = swear()
      p3 = swear.join p, p2
      
      p3.fail done
      p.abort()