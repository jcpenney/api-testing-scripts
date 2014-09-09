Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    productId = 'pp5004200088'
    reqOpts =
      uri: "#{ baseURL }/products/#{ productId }"

    Reporter.describeRequest "Fetching product #{ productId }", reqOpts

    Request reqOpts, Reporter.describeResponse