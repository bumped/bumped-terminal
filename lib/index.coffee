'use strict'

exec = require('child_process').exec

keywords =
  '$newVersion':
    regex: /\$newVersion/g
    replace: '_version'

  '$oldVersion':
    regex: /\$oldVersion/g
    replace: '_oldVersion'

deleteLastLineBreak = (str) -> str.replace /\n$/, ''

replaceAll = (str, bumped, key) ->
  str.replace keywords[key].regex, bumped[keywords[key].replace]

module.exports = (bumped, plugin, cb) ->
  plugin.command = replaceAll plugin.command, bumped, key for key of keywords
  ps = exec plugin.command

  ps.stdout.on 'data', (data) =>
    plugin.logger.success data

  ps.stderr.on 'data', (data) ->
    plugin.logger.error deleteLastLineBreak data

  ps.on 'close', (code) ->
    return cb() unless code
    plugin.logger.error "Process exited with code #{code}"
    cb true
