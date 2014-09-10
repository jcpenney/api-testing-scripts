_ = require 'lodash'
EndpointHelper = require "#{ __dirname }/../../lib/endpoint_helper"
Request = require 'request'

module.exports = (baseURL, options, callback) ->

  EndpointHelper.presentWarning 'Note that account creation will fail if the email is already associated with another account.'

  reqOpts =
    json:
      email: options.credentials.email
      password: options.credentials.password
      firstName: 'Jay-C'
      lastName: 'Penney'
      emailOptin: true
    method: 'POST'
    uri: "#{ baseURL }/customer"

  EndpointHelper.describeRequest "Creating account...", reqOpts

  Request reqOpts, _.partialRight(EndpointHelper.handleResponse, callback)
