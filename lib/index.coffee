'use strict'

terminal = require 'oh-my-terminal'

module.exports = (bumped, plugin, cb) ->

  terminal.spawn plugin.command, (child) ->

    term =
      stdout: ''
      stderr: ''

    child.stdout.on 'data', (data) ->
      term.stdout += data

    child.stderr.on 'data', (data) ->
      term.stderr += data

    child.on 'close', (code) ->
      term.status = code

      if term.status isnt 0
        err = new Error
        err.code = code
        err.message = term.stderr
        cb err
      else
        bumped.logger.plugin term.stdout
        cb null, term
