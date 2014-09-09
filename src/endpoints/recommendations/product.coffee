Colors = require 'colors'
QS = require 'qs'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    productId = 'pp5004200088'
    url = "#{ baseURL }/recommendations/product"
    qs = { id: productId }

    console.log "\nFetching recommendations for product #{ productId } (#{ url }?#{ QS.stringify(qs) })...".cyan

    Request { uri: url, qs: qs }, Reporter.describeResponse