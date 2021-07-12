from warnings import warnpy3k
warnpy3k('In 3.x, the _builtinSuites module is removed.', stacklevel=2)
import aetools, builtin_Suite
_code_to_module = {'reqd': builtin_Suite, 
   'core': builtin_Suite}
_code_to_fullname = {'reqd': ('_builtinSuites.builtin_Suite', 'builtin_Suite'), 
   'core': ('_builtinSuites.builtin_Suite', 'builtin_Suite')}
from builtin_Suite import *

class _builtinSuites(builtin_Suite_Events, aetools.TalkTo):
    _signature = 'ascr'