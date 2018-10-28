'use strict'

spawn    = require 'execspawn'
stripEof = require 'strip-final-newline'
omit     = require 'lodash.omit'
os       = require 'os'

keywords =
  '$newVersion':
    regex: /\$newVersion/g
    replace: '_version'

  '$oldVersion':
    regex: /\$oldVersion/g
    replace: '_oldVersion'

replaceAll = (str, bumped, key) ->
  str.replace keywords[key].regex, bumped[keywords[key].replace]

###*
 * Execute a terminal command
###
module.exports = (bumped, plugin, cb) ->
  command = plugin.opts.command
  return cb new TypeError('bumped-terminal need a command.') unless command
  command = replaceAll command, bumped, key for key of keywords
  opts = omit(plugin.opts, 'command')
  log = (type, data) -> plugin.logger[type] stripEof data.toString()
  render = (type, data) -> data.toString().split(os.EOL).forEach((item) -> log type, item.trim())
  error = false
  errorMessage = null

  cmd = spawn command, plugin.options

  cmd.stdout.on 'data', (data) -> render 'success', data

  cmd.stderr.on 'data', (data) -> render 'error', data

  cmd.on 'error', (err) ->
    error = true
    errorMessage = err.message or err

  cmd.on 'exit', (code) ->
    return cb() unless error or code
    errorMessage ?= "Process exited with code #{code}"
    log 'error', errorMessage
    cb true
