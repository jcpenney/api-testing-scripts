_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  productId = 'pp5004200088'
  reqOpts =
    headers: { 'Content-Type': 'application/json' }
    uri: "#{ baseURL }/products/#{ productId }/reviews"

  EndpointHelper.describeRequest "Fetching product #{ productId } reviews...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)