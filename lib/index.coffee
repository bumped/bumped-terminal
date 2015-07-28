'use strict'

terminal        = require 'oh-my-terminal'

module.exports = (bumped, plugin, cb) ->

  plugin.command = plugin.command.replace('$newVersion', bumped._version);

  terminal.exec plugin.command, (err, term) ->
    if err
      err.message = err.message.trim()
    else
      bumped.logger.plugin term.stdout

    cb err
