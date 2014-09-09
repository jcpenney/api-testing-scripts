_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  searchTerm = 'pants'
  reqOpts =
    headers: { 'Content-Type': 'application/json' }
    qs: { q: searchTerm }
    uri: "#{ baseURL }/search"
    
  EndpointHelper.describeRequest "Searching for #{ searchTerm }...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)