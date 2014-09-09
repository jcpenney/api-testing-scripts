_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  EndpointHelper.getCookieJar baseURL, options, (err, cookieJar) ->

    return console.log "\nError authenticating.\n#{ JSON.stringify(err) }...".red if err

    reqOpts =
      jar: cookieJar
      json:
        firstName: "Jay-C (#{ (new Date()).getTime() })"
        lastName: "Penney (#{ (new Date()).getTime() })"
      method: 'PUT'
      uri: "#{ baseURL }/customer/name"

    EndpointHelper.describeRequest "Updating name for #{ options.credentials.email }...", reqOpts

    Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
