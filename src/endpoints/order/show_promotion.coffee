_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar baseURL, options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    EndpointHelper.presentUnverifiedEndpointWarning()

    promotionId = 'xxx'
    reqOpts =
      headers: { 'Content-Type': 'application/json' }
      jar: cookieJar
      uri: "#{ baseURL }/cart/promotions/#{ promotionId }"

    EndpointHelper.describeRequest "Fetching promotion #{ promotionId }...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
