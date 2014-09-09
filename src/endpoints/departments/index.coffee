Colors = require 'colors'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    url = "#{ baseURL }/departments"

    console.log "\nFetching departments (#{ url })...".cyan

    Request url, Reporter.describeResponse