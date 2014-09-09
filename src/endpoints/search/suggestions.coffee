Colors = require 'colors'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    searchTerm = 'shirts'
    url = "#{ baseURL }/search/suggestions/#{ searchTerm }"

    console.log "\nFetching suggestions for #{ searchTerm } (#{ url })...".cyan

    Request url, Reporter.describeResponse