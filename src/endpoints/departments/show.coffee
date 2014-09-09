Reporter = require "#{ __dirname }/../../lib/reporter"
Request = require 'request'

module.exports =

  test: (baseURL) ->

    departmentId = 'dept20000013'
    reqOpts =
      uri: "#{ baseURL }/departments/#{ departmentId }"

    Reporter.describeRequest "Fetching department #{ departmentId }", reqOpts

    Request reqOpts, Reporter.describeResponse