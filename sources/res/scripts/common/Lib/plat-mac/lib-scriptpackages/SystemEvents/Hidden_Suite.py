import aetools, MacOS
_code = 'tpnm'
from StdSuites.Type_Names_Suite import *

class Hidden_Suite_Events(Type_Names_Suite_Events):

    def do_script(self, _object, _attributes={}, **_arguments):
        _code = 'misc'
        _subcode = 'dosc'
        if _arguments:
            raise TypeError, 'No optional args expected'
        _arguments['----'] = _object
        _reply, _arguments, _attributes = self.send(_code, _subcode, _arguments, _attributes)
        if _arguments.get('errn', 0):
            raise aetools.Error, aetools.decodeerror(_arguments)
        if _arguments.has_key('----'):
            return _arguments['----']


_classdeclarations = {}
_propdeclarations = {}
_compdeclarations = {}
_enumdeclarations = {}