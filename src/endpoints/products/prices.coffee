Colors = require 'colors'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    productId = 'pp5004200088'
    url = "#{ baseURL }/products/#{ productId }/prices"

    console.log "\nFetching product #{ productId } prices (#{ url })...".cyan

    Request url, Reporter.describeResponse