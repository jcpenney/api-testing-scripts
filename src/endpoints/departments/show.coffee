Colors = require 'colors'
Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    departmentId = 'dept20000013'
    url = "#{ baseURL }/departments/#{ departmentId }"

    console.log "\nFetching department #{ departmentId } (#{ url })...".cyan

    Request url, Reporter.describeResponse