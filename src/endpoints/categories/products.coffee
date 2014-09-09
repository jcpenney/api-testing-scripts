_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  categoryId = 'cat100210008'
  reqOpts =
    headers: { 'Content-Type': 'application/json' }
    uri: "#{ baseURL }/categories/#{ categoryId }/products"

  EndpointHelper.describeRequest "Fetching category #{ categoryId } products...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)