_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar baseURL, options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    EndpointHelper.presentUnverifiedEndpointWarning()

    itemId = 'xxx'
    reqOpts =
      jar: cookieJar
      json:
        quantity: 2
      method: 'PUT'
      uri: "#{ baseURL }/cart/items/#{ itemId }"

    EndpointHelper.describeRequest "Updating bag item #{ itemId }...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
