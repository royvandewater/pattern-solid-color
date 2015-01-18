debug   = require('debug')('pattern')
_       = require 'lodash'
meshblu = require 'meshblu'
Pattern = require './pattern'

class Command
  loadConfig: =>
    try
      return require './meshblu.json'
    catch
      console.error 'meshblu.json missing. Copy over the one from your meshblu-blinky-tape project :-)'
      process.exit 1

  run: =>
    console.log 'args', process.argv
    @config = @loadConfig()
    @animation = (new Pattern(color: process.argv[2])).generate()
    debug 'animation', JSON.stringify(@animation)

    @conn = meshblu.createConnection _.pick(@config, ['uuid', 'token', 'server', 'port'])
    @conn.on 'ready', =>
      debug 'ready'
      @conn.message {
        devices: [@config.uuid]
        animation: @animation
      }, =>
        debug 'sent'
        process.exit 0

new Command().run()
