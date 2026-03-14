import std/terminal, strutils, strformat, uri

proc banner() =
    stdout.styledWriteLine(fgYellow, """                                           
                                        ████ 
                                       ░░███ 
  ██████   ████████    ███████  ██████  ░███ 
 ░░░░░███ ░░███░░███  ███░░███ ███░░███ ░███ 
  ███████  ░███ ░███ ░███ ░███░███████  ░███ 
 ███░░███  ░███ ░███ ░███ ░███░███░░░   ░███ 
░░████████ ████ █████░░███████░░██████  █████
 ░░░░░░░░ ░░░░ ░░░░░  ░░░░░███ ░░░░░░  ░░░░░ 
                      ███ ░███               
                     ░░██████                
                      ░░░░░░
                      """)
    stdout.styledWriteLine(fgYellow, "author: prophetniko")
    
proc commandHelp() =
    echo """
    put help stuff here later when angel is more complete
    """

proc commandExit() =
    stdout.styledWriteLine(fgYellow, "exiting angel, happy hunting!")
    quit(0)

proc isValidUrl(url: string): bool =
  let parsed = parseUri(url)
  return not parsed.scheme.isEmptyOrWhitespace() and 
         not parsed.hostname.isEmptyOrWhitespace()    

proc collectPages(url: string) =
    if not isValidUrl(url):
        stdout.styledWriteLine(fgRed, &"Invalid URL structure \"{url}\"")

proc startup() =
    hideCursor()
    defer: showCursor()

    eraseScreen()
    setCursorPos(0,0)

    banner()

proc repl() =
  echo "enter \"help\" to display help menu"

  while true:
    stdout.write("angel > ")
    stdout.flushFile()

    let raw = stdin.readLine()
    let input = raw.strip()

    if input.len == 0: continue

    let parts = input.splitWhitespace()
    if parts.len == 0: continue 

    let cmd = parts[0].toLowerAscii()

    case cmd
    of "help":
      commandHelp()
    of "collect":
        echo "this is a temp command, remove later"
        collectPages(parts[1])
    of "exit", "quit", "q":
      commandExit()
    else:
      stdout.styledWriteLine(fgRed, &"unknown command \"{cmd}\"")

    
proc ctrlc() {.noconv.} =
    echo "\n"
    commandExit()

when isMainModule:
  setControlCHook(ctrlc)
  startup()
  repl()