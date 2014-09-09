Colors = require 'colors'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    productId = 'pp5004200088'
    reqOpts =
      uri: "#{ baseURL }/products/#{ productId }/reviews"

    Reporter.describeRequest "Fetching product #{ productId } reviews", reqOpts

    Request reqOpts, Reporter.describeResponse