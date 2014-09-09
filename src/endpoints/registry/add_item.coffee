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
        skuId: '78660560034'
        lotId: '7866056'
        ppId: 'pp5002620229'
        quantity: 1
      method: 'POST'
      uri: "#{ baseURL }/registry/items"

    EndpointHelper.describeRequest "Creating item for #{ options.credentials.email }'s registry", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
