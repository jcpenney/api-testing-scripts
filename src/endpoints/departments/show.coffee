_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  departmentId = 'dept20000013'
  reqOpts =
    headers: { 'Content-Type': 'application/json' }
    uri: "#{ options.environment.baseURL }/departments/#{ departmentId }"

  EndpointHelper.describeRequest "Fetching department #{ departmentId }...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)