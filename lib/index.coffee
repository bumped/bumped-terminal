'use strict'

terminal = require 'oh-my-terminal'

keywords =
  '$newVersion': '_version'
  '$oldVersion': '_oldVersion'

module.exports = (bumped, plugin, cb) ->

  plugin.command = plugin.command.replace(key, bumped[value]) for key, value of keywords

  terminal.exec plugin.command, (err, term) ->
    err.message = err.message.trim() if err
    cb err, term.stdout
