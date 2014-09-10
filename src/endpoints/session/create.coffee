_ = require 'lodash'
Request = require('request').defaults({ jar: true })
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"

module.exports = (options, callback) ->

  reqOpts =
    json: options.credentials
    method: 'POST'
    uri: "#{ options.environment.baseURL }/session"
    
  EndpointHelper.describeRequest "Signing in #{ options.credentials.email }...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)