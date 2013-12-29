String::format = (format) ->
  args = arguments
  sprintfRegex = /\{(\d+)\}/g

  sprintf = (match, number) ->
    if number of args
      return args[number]
    else
      return match

  @replace sprintfRegex, sprintf
