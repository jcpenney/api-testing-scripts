Colors = require 'colors'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    categoryId = 'cat100210008'
    url = "#{ baseURL }/categories/#{ categoryId }"

    console.log "\nFetching category #{ categoryId } (#{ url })...".cyan

    Request url, Reporter.describeResponse
