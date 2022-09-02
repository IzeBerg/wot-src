import warnings as w
w.warn(__doc__, DeprecationWarning, stacklevel=2)
from sys import version
IDLE_VERSION = version[:version.index(' ')]