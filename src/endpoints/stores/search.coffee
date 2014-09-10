_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (options, callback) ->

  searchTerm = '10012'
  reqOpts =
    headers: { 'Content-Type': 'application/json' }
    qs: { q: searchTerm }
    uri: "#{ options.environment.baseURL }/stores/#{ searchTerm }"
    
  EndpointHelper.describeRequest "Searching for stores near #{ searchTerm }...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)