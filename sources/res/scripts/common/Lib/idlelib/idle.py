import os.path, sys
idlelib_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, idlelib_dir)
import idlelib.PyShell
idlelib.PyShell.main()