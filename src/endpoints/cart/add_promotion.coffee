_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    EndpointHelper.presentUnverifiedEndpointWarning()

    reqOpts =
      jar: cookieJar
      json:
        type: 'COUPON'
        code: 'SHOPDEC'
      method: 'POST'
      uri: "#{ options.environment.baseURL }/cart/promotions"

    EndpointHelper.describeRequest "Adding promotion to #{ options.credentials.email }'s bag...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
