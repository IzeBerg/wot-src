import os.path, sys
idlelib_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if idlelib_dir not in sys.path:
    sys.path.insert(0, idlelib_dir)
from idlelib.PyShell import main
main()