_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    EndpointHelper.presentUnverifiedEndpointWarning()

    itemId = 'xxx'
    reqOpts =
      headers: { 'Content-Type': 'application/json' }
      jar: cookieJar
      method: 'DELETE'
      uri: "#{ options.environment.baseURL }/cart/items/#{ itemId }"

    EndpointHelper.describeRequest "Removing item #{ itemId } from #{ options.credentials.email }'s bag...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
