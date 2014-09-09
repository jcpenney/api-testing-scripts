_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  searchTerm = '10012'
  reqOpts =
    headers: { 'Content-Type': 'application/json' }
    qs: { q: searchTerm }
    uri: "#{ baseURL }/stores/#{ searchTerm }"
    
  EndpointHelper.describeRequest "Searching for stores near #{ searchTerm }...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)