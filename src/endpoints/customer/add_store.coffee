_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  EndpointHelper.getAuthenticatedCookieJar baseURL, options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    EndpointHelper.presentWarning 'Note that store creation will fail if store ID is already associated with user.'

    reqOpts =
      jar: cookieJar
      json:
        firstName: 'Jay-C'
        lastName: 'Penney'
        phone: '8003221189'
        storeNumber: '2297' # '0174' # 2718
        isDefault: true
      method: 'POST'
      uri: "#{ baseURL }/customer/stores"

    EndpointHelper.describeRequest "Creating a new store for customer #{ options.credentials.email }...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
