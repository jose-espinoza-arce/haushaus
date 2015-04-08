do ($ = jQuery , sr = "smartresize")->
  debounce = (func, threshold , execAsap)->
    timeout = undefined
    debounced = ->
      delayed = ->
        func.apply obj, args unless execAsap
        timeout = null
        return
      obj = this
      args = arguments
      if timeout
        clearTimeout timeout
      else func.apply obj, args if execAsap
      timeout = setTimeout( delayed, threshold or 100 )
      return

  $.fn[sr] = (fn) ->
    (if fn then @bind("load resize", debounce(fn)) else @trigger(sr))
    return
  return




