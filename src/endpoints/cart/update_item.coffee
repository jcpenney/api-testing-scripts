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

    EndpointHelper.describeRequest "Updating item #{ itemId } from #{ options.credentials.email }'s bag...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
