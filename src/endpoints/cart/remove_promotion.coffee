_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    EndpointHelper.presentUnverifiedEndpointWarning()

    promotionId = 'xxx'
    reqOpts =
      headers: { 'Content-Type': 'application/json' }
      jar: cookieJar
      method: 'DELETE'
      uri: "#{ options.environment.baseURL }/cart/promotions/#{ promotionId }"

    EndpointHelper.describeRequest "Removing promotion #{ promotionId } from #{ options.credentials.email }'s bag...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
