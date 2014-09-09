_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  EndpointHelper.getCookieJar baseURL, options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    addressId = 'c1userci116080204'
    reqOpts =
      jar: cookieJar
      json:
        firstName: "Jay-C"
        lastName: "Penney"
        addressLineOne: '200 Lafayette Street'
        addressLineTwo: null
        city: 'New York'
        state: 'NY'
        zip: '10012'
        country: 'US'
        phone: '8003221189'
      method: 'PUT'
      uri: "#{ baseURL }/customer/addresses/#{ addressId }"

    EndpointHelper.describeRequest "Updating address #{ addressId } for customer #{ options.credentials.email }...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
