_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    reqOpts =
      jar: cookieJar
      json:
        firstName: "Jay-C"
        lastName: "Penney"
      method: 'PUT'
      uri: "#{ options.environment.baseURL }/customer/name"

    EndpointHelper.describeRequest "Updating #{ options.credentials.email }'s name...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
