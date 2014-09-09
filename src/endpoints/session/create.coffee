_ = require 'lodash'
Request = require('request').defaults({ jar: true })
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"

module.exports = (baseURL, options, callback) ->

  reqOpts =
    json: options.credentials
    method: 'POST'
    uri: "#{ baseURL }/session"
    
  EndpointHelper.describeRequest "Authenticating...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)