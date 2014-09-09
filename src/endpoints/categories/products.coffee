Colors = require 'colors'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    categoryId = 'cat100210008'
    url = "#{ baseURL }/categories/#{ categoryId }/products"

    console.log "\nFetching category #{ categoryId } products (#{ url })...".cyan

    Request url, Reporter.describeResponse