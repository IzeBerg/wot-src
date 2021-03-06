import aetools, MacOS
_code = 'powr'

class Power_Suite_Events:

    def restart(self, _object, _attributes={}, **_arguments):
        _code = 'fndr'
        _subcode = 'rest'
        if _arguments:
            raise TypeError, 'No optional args expected'
        _arguments['----'] = _object
        _reply, _arguments, _attributes = self.send(_code, _subcode, _arguments, _attributes)
        if _arguments.get('errn', 0):
            raise aetools.Error, aetools.decodeerror(_arguments)
        if _arguments.has_key('----'):
            return _arguments['----']

    def shut_down(self, _object, _attributes={}, **_arguments):
        _code = 'fndr'
        _subcode = 'shut'
        if _arguments:
            raise TypeError, 'No optional args expected'
        _arguments['----'] = _object
        _reply, _arguments, _attributes = self.send(_code, _subcode, _arguments, _attributes)
        if _arguments.get('errn', 0):
            raise aetools.Error, aetools.decodeerror(_arguments)
        if _arguments.has_key('----'):
            return _arguments['----']

    def sleep(self, _object, _attributes={}, **_arguments):
        _code = 'fndr'
        _subcode = 'slep'
        if _arguments:
            raise TypeError, 'No optional args expected'
        _arguments['----'] = _object
        _reply, _arguments, _attributes = self.send(_code, _subcode, _arguments, _attributes)
        if _arguments.get('errn', 0):
            raise aetools.Error, aetools.decodeerror(_arguments)
        if _arguments.has_key('----'):
            return _arguments['----']


class application(aetools.ComponentItem):
    want = 'capp'


class _Prop__3c_Inheritance_3e_(aetools.NProperty):
    which = 'c@#^'
    want = 'capp'


_3c_Inheritance_3e_ = _Prop__3c_Inheritance_3e_()

class _Prop_folder_actions_enabled(aetools.NProperty):
    which = 'faen'
    want = 'bool'


folder_actions_enabled = _Prop_folder_actions_enabled()

class _Prop_properties(aetools.NProperty):
    which = 'pALL'
    want = '****'


properties = _Prop_properties()
applications = application
application._superclassnames = []
import Disk_Folder_File_Suite, Standard_Suite, Folder_Actions_Suite, Login_Items_Suite, Processes_Suite
application._privpropdict = {'_3c_Inheritance_3e_': _Prop__3c_Inheritance_3e_, 
   'folder_actions_enabled': _Prop_folder_actions_enabled, 
   'properties': _Prop_properties}
application._privelemdict = {'application_process': Processes_Suite.application_process, 
   'desk_accessory_process': Processes_Suite.desk_accessory_process, 
   'disk': Disk_Folder_File_Suite.disk, 
   'document': Standard_Suite.document, 
   'file': Disk_Folder_File_Suite.file, 
   'folder': Disk_Folder_File_Suite.folder, 
   'folder_action': Folder_Actions_Suite.folder_action, 
   'item': Disk_Folder_File_Suite.item, 
   'login_item': Login_Items_Suite.login_item, 
   'process': Processes_Suite.process, 
   'window': Standard_Suite.window}
_classdeclarations = {'capp': application}
_propdeclarations = {'c@#^': _Prop__3c_Inheritance_3e_, 
   'faen': _Prop_folder_actions_enabled, 
   'pALL': _Prop_properties}
_compdeclarations = {}
_enumdeclarations = {}