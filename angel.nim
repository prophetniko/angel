import std/terminal, strutils, strformat

proc banner() =
    stdout.styledWriteLine(fgCyan, """                                           
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
    stdout.styledWriteLine(fgCyan, "author: prophetniko")
    
proc commandHelp() =
    echo """
    put help stuff here later when angel is more complete
    """

proc commandExit() =
    stdout.styledWriteLine(fgCyan, "exiting angel, happy hunting!")
    quit(0)

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
        var input = stdin.readLine()
        var args: seq[string] =  input.splitWhitespace()
        var command = args[0].toLowerAscii()

        if command == "help":
            commandHelp()
        elif command == "exit":
            commandExit()
        else:
            stdout.styledWriteLine(fgRed, &"Unknown command \"{command}\"")
    
proc ctrlc() {.noconv.} =
    echo "\n"
    commandExit()

when isMainModule:
  setControlCHook(ctrlc)
  startup()
  repl()