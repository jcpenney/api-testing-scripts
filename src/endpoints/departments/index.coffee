Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    reqOpts =
      uri: "#{ baseURL }/departments"

    Reporter.describeRequest "Fetching departments", reqOpts

    Request reqOpts, Reporter.describeResponse