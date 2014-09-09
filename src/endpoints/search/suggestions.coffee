_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  searchTerm = 'shirts'
  reqOpts = 
    headers: { 'Content-Type': 'application/json' }
    uri: "#{ baseURL }/search/suggestions/#{ searchTerm }"

  EndpointHelper.describeRequest "Fetching suggestions for #{ searchTerm }...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)