import sys
import os

arguments_message = "Use an arg:\n\nnight ( [screen kelvin]/none (2500) )\n"

if len(sys.argv) < 2:
    print(arguments_message)

match sys.argv[1]:
    case "night":
        if len(sys.argv) > 2:
            if sys.argv[2] == "kill":
                os.system("kill $(pgrep hyprsunset)") 

        if len(sys.argv) < 3:
            os.system("nohup hyprsunset -t 2500")
        else:
            os.system("nohup hyprsunset -t " + sys.argv[2])

