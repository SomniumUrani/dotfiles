import sys
import subprocess
import os

tlp_line_spacing = 60

if len(sys.argv) < 2:
    print("Give an arg")
    sys.exit(1)

match sys.argv[1]:
    case "charge":
        statstr = subprocess.check_output(['sudo', "tlp-stat", '-b'], text=True)
        chargestr = [line for line in statstr.splitlines() if "Charge" in line]

        print('Internal Battery Charge\t', chargestr[0][tlp_line_spacing:])
        print('External Battery Charge\t', chargestr[1][tlp_line_spacing:])
        print('Total\t\t\t', chargestr[2][tlp_line_spacing:])

    case "set":
        match sys.argv[2]:
            case "home":
                os.system("sudo tlp setcharge 40 80 BAT0 && sudo tlp setcharge 40 80 BAT1")
            case "outside":
                os.system("sudo tlp setcharge 75 85 BAT0 && sudo tlp setcharge 75 85 BAT1")
            case "full":
                os.system("sudo tlp fullcharge")
    
    case _:
        print("what?")
