import sys
import subprocess
import os

tlp_line_spacing = 60

arg_message = "Give an arg like\ncharge\nset (home/outside/full)\n"


if len(sys.argv) < 2:
    print(arg_message)
    sys.exit(1)

def statf():
        return subprocess.check_output(['sudo', "tlp-stat", '-b'], text=True)

match sys.argv[1]:
    case "charge":
        statstr = statf()
        argument_string = [line for line in statstr.splitlines() if "Charge" in line]

        print('Internal Battery Charge\t', argument_string[0][tlp_line_spacing:])
        print('External Battery Charge\t', argument_string[1][tlp_line_spacing:])
        print('Total\t\t\t', argument_string[2][tlp_line_spacing:])

    case "set":
        match sys.argv[2]:
            case "home":
                os.system("sudo tlp setcharge 40 80 BAT0 && sudo tlp setcharge 40 80 BAT1")
            case "outside":
                os.system("sudo tlp setcharge 75 85 BAT0 && sudo tlp setcharge 75 85 BAT1")
            case "full":
                os.system("sudo tlp fullcharge")
    case "status":
        if sys.argv[2] == "suckless":
            statstr = statf()
            argument_string = [line for line in statstr.splitlines() if "Charge" in line]
        else:
            os.system("sudo tlp-stat -b")
    
    case _:
        print(arg_message)
