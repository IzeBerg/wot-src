__revision__ = '$Id$'
import os
if os.name == 'posix':
    from Crypto.Random.OSRNG.posix import new
elif os.name == 'nt':
    from Crypto.Random.OSRNG.nt import new
elif hasattr(os, 'urandom'):
    from Crypto.Random.OSRNG.fallback import new
else:
    raise ImportError('Not implemented')