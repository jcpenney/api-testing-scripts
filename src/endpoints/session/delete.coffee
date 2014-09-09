_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  EndpointHelper.getCookieJar baseURL, options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    reqOpts =
      headers: { 'Content-Type': 'application/json' }
      jar: cookieJar
      method: 'delete'
      uri: "#{ baseURL }/session"

    EndpointHelper.describeRequest "Signing out...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
