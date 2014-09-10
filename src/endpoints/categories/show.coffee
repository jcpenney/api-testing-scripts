_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  categoryId = 'cat100210008'
  reqOpts =
    headers: { 'Content-Type': 'application/json' }
    uri: "#{ options.environment.baseURL }/categories/#{ categoryId }"

  EndpointHelper.describeRequest "Fetching category #{ categoryId }...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
