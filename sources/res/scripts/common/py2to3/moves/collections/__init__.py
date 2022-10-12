from __future__ import absolute_import
from py2to3.utils import PY3
if PY3:
    from collections import *
else:
    from collections import *
    from UserList import UserList
    from UserDict import UserDict
    from UserString import UserString
    from future.backports.misc import ChainMap, count, recursive_repr, cmp_to_key