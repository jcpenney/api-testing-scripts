_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  reqOpts =
    headers: { 'Content-Type': 'application/json' }
    uri: "#{ options.environment.baseURL }/departments"

  EndpointHelper.describeRequest "Fetching departments...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)