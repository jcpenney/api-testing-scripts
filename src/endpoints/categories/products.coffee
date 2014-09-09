Colors = require 'colors'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    categoryId = 'cat100210008'
    reqOpts =
      uri: "#{ baseURL }/categories/#{ categoryId }/products"

    Reporter.describeRequest "Fetching category #{ categoryId } products", reqOpts

    Request reqOpts, Reporter.describeResponse