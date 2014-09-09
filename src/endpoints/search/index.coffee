Colors = require 'colors'
QS = require 'qs'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    searchTerm = 'pants'
    reqOpts =
      uri: "#{ baseURL }/search"
      qs: { q: searchTerm }

    Reporter.describeRequest "Searching for #{ searchTerm }", reqOpts

    Request reqOpts, Reporter.describeResponse