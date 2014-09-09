##############################################################################
# Imports
##############################################################################

_ = require 'lodash'
Colors = require 'colors'
Config = require "#{ __dirname }/config"
FS = require 'fs'
Prompt = require 'cli-prompt'


##############################################################################
# Helpers
##############################################################################

getDirectories = (path) ->
  FS.readdirSync(path).filter (filename) ->
    FS.statSync("#{ path }/#{ filename }").isDirectory()

getFiles = (path) ->
  FS.readdirSync(path).filter (filename) ->
    !FS.statSync("#{ path }/#{ filename }").isDirectory()

removeExtension = (filename) ->
  lastDotIndex = filename.lastIndexOf '.'
  return filename if lastDotIndex is -1
  filename.substr 0, lastDotIndex


##############################################################################
# User Input Prompts
##############################################################################

promptForEnvironment = (callback) ->
  environments = Config.environments
  return callback { message: 'No available environments' } if not environments.length
  promptText = "\nWhich environment would you like to test?".cyan
  for environment, i in environments
    promptText += "\n#{ i + 1 }) #{ environment.name } (#{ environment.baseURL })".yellow
  promptText += "\n\n"
  Prompt promptText, (val) ->
    index = parseInt val.trim()
    if _.isNaN(index) or index < 1 or index > environments.length
      console.log "\nPlease specify a valid environment (1-#{ environments.length }).".red
      promptForEnvironment callback
    else
      callback null, environments[index - 1] if callback

promptForResource = (callback) ->
  resources = getDirectories "#{ __dirname }/endpoints"
  return callback { message: 'No available resources' } if not resources.length
  promptText = "\nWhich resource would you like to test?".cyan
  for resource, i in resources
    promptText += "\n#{ i + 1 }) #{ resource }".yellow
  promptText += "\n\n"
  Prompt promptText, (val) ->
    index = parseInt val.trim()
    if _.isNaN(index) or index < 1 or index > resources.length
      console.log "\nPlease specify a valid resource (1-#{ resources.length }".red
      promptForResource callback
    else
      callback null, resources[index - 1] if callback

promptForResourceAction = (resource, callback) ->
  actions = getFiles "#{ __dirname }/endpoints/#{ resource }"
  return callback { message: 'No available actions' } if not actions.length
  promptText = "\nWhich action would you like to test?".cyan
  for action, i in actions
    promptText += "\n#{ i + 1 }) #{ removeExtension(action) }".yellow
  promptText += "\n\n"
  Prompt promptText, (val) ->
    index = parseInt val.trim()
    if _.isNaN(index) or index < 1 or index > actions.length
      console.log "\nPlease specify a valid action (1-#{ actions.length })".red
      promptForResourceAction resource, callback
    else
      callback null, actions[index - 1] if callback 


##############################################################################
# Script Flow
##############################################################################

promptForEnvironment (err, environment) ->
  return console.error err.message.red if err
  promptForResource (err, resource) ->
    return console.error err.message.red if err
    promptForResourceAction resource, (err, action) ->
      return console.error err.message.red if err
      endpoint = require "#{ __dirname }/endpoints/#{ resource }/#{ action }"
      endpoint.test environment.baseURL




