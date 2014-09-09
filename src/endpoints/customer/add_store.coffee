_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar baseURL, options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    reqOpts =
      jar: cookieJar
      json:
        firstName: 'Jay-C'
        lastName: 'Penney'
        phone: '8003221189'
        storeNumber: '0174'
        isDefault: true
      method: 'POST'
      uri: "#{ baseURL }/customer/stores"

    EndpointHelper.describeRequest "Creating a new store for customer #{ options.credentials.email }", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
