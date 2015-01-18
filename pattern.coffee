_ = require 'lodash'

class Pattern
  constructor: (options={}) ->
    @ledCount = 14
    @color = options.color ? 'black'

  frame: =>
    _.times @ledCount, => @color

  generate: =>
    [@frame()]

module.exports = Pattern
