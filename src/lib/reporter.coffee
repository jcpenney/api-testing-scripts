module.exports =

  describeRequest: (message, requestOptions) ->
    console.log "\n#{ message }".cyan if message
    console.log "#{ JSON.stringify(requestOptions) }".yellow

  describeResponse: (err, httpResponse, body) ->
    if err
      console.error "\nRequest error.".red
      console.error "\n#{ JSON.stringify(err) }\n".red
    else if /^4|^5/.test String(httpResponse.statusCode)
      console.error "\nStatus Code: #{ httpResponse.statusCode }".red
      console.error "\n#{ body.red }\n"
    else
      console.log "\nStatus Code: #{ httpResponse.statusCode }".green
      console.log "\n#{ body.green }\n"
