import aetools, MacOS
_code = 'MOSS'

class Netscape_Suite_Events:

    def Open_bookmark(self, _object=None, _attributes={}, **_arguments):
        _code = 'MOSS'
        _subcode = 'book'
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