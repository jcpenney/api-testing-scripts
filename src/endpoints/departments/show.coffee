_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  departmentId = 'dept20000013'
  reqOpts =
    headers: { 'Content-Type': 'application/json' }
    uri: "#{ baseURL }/departments/#{ departmentId }"

  EndpointHelper.describeRequest "Fetching department #{ departmentId }...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)