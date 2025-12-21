#!/usr/bin/python3
import sys
import os

arguments_message = "Use an arg:\n\nnight [screen kelvin]\n"

if len(sys.argv) < 2:
    print(arguments_message)

match sys.argv[1]:
    case "night":
        if len(sys.argv) == 3:
            if sys.argv[2] == "kill":
                os.system("kill $(pgrep hyprsunset)") 

        if len(sys.argv) < 3:
            os.system("nohup hyprsunset -t 2500 > /dev/null 2>&1 & ")
        else:
            os.system("nohup hyprsunset -t  > /dev/null 2>&1 & " + sys.argv[2])
    case _:
        print(arguments_message)

