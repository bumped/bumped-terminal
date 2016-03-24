'use strict'

stripEof = require 'strip-eof'
exec = require('child_process').exec

keywords =
  '$newVersion':
    regex: /\$newVersion/g
    replace: '_version'

  '$oldVersion':
    regex: /\$oldVersion/g
    replace: '_oldVersion'

createLogger = (logger) ->
  logState = (state, messages) ->
    logger[state] message for message in messages when message isnt ''
  return logState

replaceAll = (str, bumped, key) ->
  str.replace keywords[key].regex, bumped[keywords[key].replace]

module.exports = (bumped, plugin, cb) ->
  logState = createLogger plugin.logger
  plugin.command = replaceAll plugin.command, bumped, key for key of keywords

  exec plugin.command, (err, stdout, stderr) ->
    if err
      code = err.code
      err = true
      buffer = stderr
      type = 'error'
    else
      buffer = stdout
      type = 'success'

    logState(type, stripEof(buffer).split('\n'))
    plugin.logger.error "Process exited with code #{code}" if code
    cb err
