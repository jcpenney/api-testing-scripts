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
        items: [
          {
            id: '25112010121'
            ppId: 'pp5002960883'
            quantity: 2
          }
        ]
      method: 'POST'
      uri: "#{ baseURL }/cart/items"

    EndpointHelper.describeRequest "Adding item to #{ options.credentials.email }'s bag", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
