#!/usr/bin/python3
import sys
import os

arguments_message = "Use an arg:\n\nnight [screen kelvin]\n"

if len(sys.argv) < 2:
    print(arguments_message)

match sys.argv[1]:
    case "night":
        arg2 = sys.argv[2] if len(sys.argv) > 2 else None

        if sys.argv[2] == "kill":
            os.system("kill $(pgrep hyprsunset)") 
        elif arg2 is None or not arg2.isdigit():
            os.system("nohup hyprsunset -t 1500 > /dev/null 2>&1 & ")
        else:
            os.system(f"nohup hyprsunset -t {arg2} > /dev/null 2>&1 & ")
    case _:
        print(arguments_message)

