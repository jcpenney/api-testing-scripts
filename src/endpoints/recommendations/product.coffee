Colors = require 'colors'
QS = require 'qs'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    productId = 'pp5004200088'
    reqOpts =
      uri: "#{ baseURL }/recommendations/product"
      qs: { id: productId }

    Reporter.describeRequest "Fetching recommendations for product #{ productId }", reqOpts

    Request reqOpts, Reporter.describeResponse