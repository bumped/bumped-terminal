'use strict'

term = require 'oh-my-terminal'

keywords =
  '$newVersion':
    regex: /\$newVersion/g
    replace: '_version'

  '$oldVersion':
    regex: /\$oldVersion/g
    replace: '_oldVersion'

deleteLastLineBreak = (str) -> str.replace /\n$/, ''

printMessage = (logger, messages) ->
  logger.success message for message in messages.split '\n' when message isnt ''

printMessages = (logger, term) ->
  printMessage logger, term[type] for type in ['stdout', 'stderr'] when term[type] isnt ''

replaceAll = (str, bumped, key) ->
  str.replace keywords[key].regex, bumped[keywords[key].replace]

module.exports = (bumped, plugin, cb) ->

  plugin.command = replaceAll plugin.command, bumped, key for key of keywords

  options = output: if plugin.output? then plugin.ouptut else true

  term.exec plugin.command, (err, term) ->

    if err
      err.message = deleteLastLineBreak term.stderr
    else
      printMessages plugin.logger, term

    cb err
