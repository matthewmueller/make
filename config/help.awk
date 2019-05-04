{
  if ($0 ~ /^[a-zA-Z\-\_0-9\.%]+:/) {
    helpCommand = substr($0, 0, index($0, ":") - 1)
    if (helpMessage) {
      printf "  %-20s %s\n", helpCommand, helpMessage
      helpMessage = ""
    }
  } else if ($0 ~ /^##/) {
    if (helpMessage) {
      helpMessage = helpMessage "\n                       " substr($0, 3)
    } else {
      helpMessage = substr($0, 3)
    }
  } else {
    if (helpMessage) {
      print "\n\033[1m" substr(helpMessage, 2) "\033[0m\n"
    }
    helpMessage = "";
  }
}