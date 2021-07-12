import aetools, MacOS
_code = 'MSIE'

class Microsoft_Internet_Explorer_Events:

    def GetSource(self, _object=None, _attributes={}, **_arguments):
        _code = 'MSIE'
        _subcode = 'SORC'
        if _arguments:
            raise TypeError, 'No optional args expected'
        _arguments['----'] = _object
        _reply, _arguments, _attributes = self.send(_code, _subcode, _arguments, _attributes)
        if _arguments.get('errn', 0):
            raise aetools.Error, aetools.decodeerror(_arguments)
        if _arguments.has_key('----'):
            return _arguments['----']

    def PrintBrowserWindow(self, _object=None, _attributes={}, **_arguments):
        _code = 'misc'
        _subcode = 'pWND'
        if _arguments:
            raise TypeError, 'No optional args expected'
        _arguments['----'] = _object
        _reply, _arguments, _attributes = self.send(_code, _subcode, _arguments, _attributes)
        if _arguments.get('errn', 0):
            raise aetools.Error, aetools.decodeerror(_arguments)
        if _arguments.has_key('----'):
            return _arguments['----']

    _argmap_do_script = {'window': 'WIND'}

    def do_script(self, _object, _attributes={}, **_arguments):
        _code = 'misc'
        _subcode = 'dosc'
        aetools.keysubst(_arguments, self._argmap_do_script)
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