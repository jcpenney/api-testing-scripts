Colors = require 'colors'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    productId = 'pp5004200088'
    url = "#{ baseURL }/products/#{ productId }/reviews"

    console.log "\nFetching product #{ productId } reviews (#{ url })...".cyan

    Request url, Reporter.describeResponse