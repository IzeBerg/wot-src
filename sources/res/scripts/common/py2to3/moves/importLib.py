from __future__ import absolute_import
from py2to3.utils import PY3
if PY3:
    from importlib import reload
else:
    from __builtin__ import reload