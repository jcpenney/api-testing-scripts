_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    reqOpts =
      headers: { 'Content-Type': 'application/json' }
      jar: cookieJar
      uri: "#{ options.environment.baseURL }/customer/addresses"

    EndpointHelper.describeRequest "Fetching customer #{ options.credentials.email }'s addresses...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
