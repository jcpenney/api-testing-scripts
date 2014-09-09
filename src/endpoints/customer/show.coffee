_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require('request').defaults { jar: true }
ToughCookie = require 'tough-cookie'

module.exports = (baseURL, options, callback) ->

  EndpointHelper.getCookie baseURL, options, (err, cookie) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    Request.cookie cookie

    reqOpts =
      headers: { 'Content-Type': 'application/json' }
      uri: "#{ baseURL }/customer/addresses"

    EndpointHelper.describeRequest "Fetching customer", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
