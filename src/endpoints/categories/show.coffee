Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    categoryId = 'cat100210008'
    reqOpts =
      uri: "#{ baseURL }/categories/#{ categoryId }"

    Reporter.describeRequest "Fetching category #{ categoryId }", reqOpts

    Request reqOpts, Reporter.describeResponse
