Colors = require 'colors'
QS = require 'qs'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    searchTerm = 'pants'
    url = "#{ baseURL }/search"
    qs = { q: searchTerm }

    console.log "\nSearching for #{ searchTerm } (#{ url }?#{ QS.stringify(qs) })...".cyan

    Request { uri: url, qs: qs }, Reporter.describeResponse