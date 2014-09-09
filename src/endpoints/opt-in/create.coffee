_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar baseURL, options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    EndpointHelper.presentUnverifiedEndpointWarning()
    
    reqOpts =
      jar: cookieJar
      json:
        type: 'EMAIL'
        value: options.credentials.email
      method: 'POST'
      uri: "#{ baseURL }/optin"

    EndpointHelper.describeRequest "Opting in for email notifications to #{ options.credentials.email }", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
