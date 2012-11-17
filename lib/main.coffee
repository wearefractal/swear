nextTick = (fn) ->
  if process?
    process.nextTick fn
  else
    setTimeout fn, 0

swear = ->
  p =
    efns: []
    fns: []
    completed: false

    wrap: ->
      (e, d...) ->
        return p.abort e if e?
        return p.resolve d...

    resolve: (val...) ->
      p.val = val
      p.completed = true
      cb val... for cb in p.fns
      return p

    abort: (e) ->
      p.err = e
      p.completed = true
      cb e for cb in p.efns
      return p

    fail: (cb) ->
      if p.err
        nextTick -> cb p.err
      else
        p.efns.push cb
      return p

    when: (cb) ->
      if p.val
        nextTick -> cb p.val...
      else
        p.fns.push cb
      return p

swear.join = (promises...) ->
  arr = []
  n = swear()
  handle = (d...) ->
    next = promises.pop()
    return n.resolve arr... unless next
    next.when (a...) ->
      arr.push a
      handle a...
  p.fail n.abort for p in promises
  handle()
  return n

if module?
  module.exports = swear
else
  window.swear = swear