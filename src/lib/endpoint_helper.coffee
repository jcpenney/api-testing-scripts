_ = require 'lodash'
FormatJSON = require 'format-json'
Request = require 'request'

helper = {}

helper.describeRequest = (message, requestOptions) ->
  requestOptions = _.cloneDeep requestOptions
  if requestOptions.jar
    requestOptions.jar = 'cookie jar data suppressed for the sake of brevity'
  console.log "\n#{ message }".cyan if message
  console.log "#{ FormatJSON.plain(requestOptions) }".yellow

helper.describeResponse = (err, httpResponse, body) ->
  if err
    console.error "\nRequest error.".red
    console.error "\n#{ FormatJSON.plain(err) }\n".red
  else if /^4|^5/.test String(httpResponse.statusCode)
    try
      body = FormatJSON.plain JSON.parse(body)
    catch e
      #
    console.error "\nStatus Code: #{ httpResponse.statusCode }".red
    console.error "\n#{ if body then body.red else 'No body.'.red }\n"
  else
    try
      body = FormatJSON.plain JSON.parse(body)
    catch e
      #
    console.log "\nStatus Code: #{ httpResponse.statusCode }".green
    console.log "\n#{ if body then body.green else 'No body.'.green }\n"

helper.handleResponse = (err, httpResponse, body, callback) ->
  helper.describeResponse err, httpResponse, body
  callback err, httpResponse, body if callback

helper.getAuthenticatedCookieJar = (baseURL, options, callback) ->
  CreateSession = require "#{ __dirname }/../endpoints/session/create"
  CreateSession baseURL, options, (err, httpResponse, body) ->
    return callback(err) if err
    cookies = httpResponse.headers['set-cookie']
    return callback { message: 'Cookies not found' } if not cookies
    cookieJar = Request.jar()
    cookies.forEach (cookie) ->
      cookieJar.setCookie cookie, baseURL
    callback err, cookieJar

module.exports = helper