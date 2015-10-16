'use strict'

terminal = require 'oh-my-terminal'

keywords =
  '$newVersion': '_version'
  '$oldVersion': '_oldVersion'

deleteLastLineBreak = (str) -> str.replace /\n$/, ''

printSuccessMessages = (logger, messages) ->
  logger.success message for message in messages when message isnt ''


module.exports = (bumped, plugin, cb) ->

  plugin.command = plugin.command.replace(key, bumped[value]) for key, value of keywords

  options =
    output: if plugin.output? then plugin.ouptut else true

  terminal.exec plugin.command, (err, term) ->

    if err
      err.message = deleteLastLineBreak term.stderr
    else
      printSuccessMessages plugin.logger, term.stdout.split('\n')

    cb err
