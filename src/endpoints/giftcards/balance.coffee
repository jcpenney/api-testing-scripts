_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    reqOpts =
      jar: cookieJar
      json:
        cardNumber: 'xxx'
        cardPin: 'xxx'
      method: 'POST'
      uri: "#{ options.environment.baseURL }/giftcards/balance"

    EndpointHelper.describeRequest "Fetching balance for gift card...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
