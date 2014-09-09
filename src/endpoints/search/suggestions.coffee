Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    searchTerm = 'shirts'
    reqOpts = 
      uri: "#{ baseURL }/search/suggestions/#{ searchTerm }"

    Reporter.describeRequest "Fetching suggestions for #{ searchTerm }", reqOpts

    Request reqOpts, Reporter.describeResponse