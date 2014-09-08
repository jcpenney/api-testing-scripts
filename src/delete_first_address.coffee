##################################################################
# Imports
##################################################################

Colors = require 'colors'
Prompt = require 'cli-prompt'
Request = require('request').defaults { jar: true }


##################################################################
# Config
##################################################################

config =
  API_BASE_URL: "https://api.jcpenney.com/v2"


##################################################################
# Sign In
##################################################################

signIn = (email, password, callback) ->

  reqOpts =
    uri: config.API_BASE_URL + "/session"
    json: { email: email, password: password }

  Request.post reqOpts, (err, httpResponse, body) ->
    return callback(err) if err
    cookie = httpResponse.headers['set-cookie'][0]
    Request.cookie(cookie) # Assigns global cookie, applied to all subsequent requests
    callback null, cookie


##################################################################
# Get Addresses
##################################################################

getAddresses = (callback) ->

  reqOpts =
    uri: config.API_BASE_URL + "/customer/addresses"

  Request.get reqOpts, (err, httpResponse, body) ->
    return callback(err) if (err)
    return callback(JSON.parse(body)) if /^4/.test String(httpResponse.statusCode)
    callback null, JSON.parse(body)


##################################################################
# Delete Address
##################################################################

deleteAddress = (addressId, callback) ->

  reqOpts =
    uri: config.API_BASE_URL + "/customer/addresses/" + addressId
    headers: { 'Content-Type': 'application/json' }

  Request.del reqOpts, (err, httpResponse, body) ->
    return callback(err) if err
    return callback(JSON.parse(body)) if /^4/.test String(httpResponse.statusCode)
    callback()


##################################################################
# Script Flow
##################################################################

Prompt "\nEnter your JCP email: ".cyan, (email) ->
  Prompt.password "Enter your JCP password: ".cyan, (password) ->
    console.log "\nSigning in...".yellow
    signIn email, password, (err, cookie) ->
      return console.error("\nError signing in:".red, JSON.stringify(err).red + "\n") if err
      console.log "\nSigned in successfully.".green
      console.log "\nFetching existing addresses...".yellow
      getAddresses (err, addresses) ->
        return console.error("\nError fetching addresses:".red, JSON.stringify(err).red + "\n") if err
        console.log "\nAddresses retrieved successfully:\n".green, addresses
        if addresses.length > 0
          addressId = addresses[0].id
          console.log "\nDeleting address ".green + addressId.green + "...".green
          deleteAddress addressId, (err) ->
            return console.error("\nError deleting address:".red, JSON.stringify(err).red + "\n") if err
            console.log "\nAddress deleted successfully\n".green
        else
          console.log "\nNo addresses to delete\n".green
