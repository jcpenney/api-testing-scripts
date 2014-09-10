_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  searchTerm = 'pants'
  reqOpts =
    headers: { 'Content-Type': 'application/json' }
    qs: { q: searchTerm }
    uri: "#{ options.environment.baseURL }/search"
    
  EndpointHelper.describeRequest "Searching for #{ searchTerm }...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)