# Stubs Generator
# import _winreg
# <module '_winreg' (built-in)>

def CloseKey(*args, **kwargs): pass
def ConnectRegistry(*args, **kwargs): pass
def CreateKey(*args, **kwargs): pass
def CreateKeyEx(*args, **kwargs): pass
def DeleteKey(*args, **kwargs): pass
def DeleteKeyEx(*args, **kwargs): pass
def DeleteValue(*args, **kwargs): pass
def DisableReflectionKey(*args, **kwargs): pass
def EnableReflectionKey(*args, **kwargs): pass
def EnumKey(*args, **kwargs): pass
def EnumValue(*args, **kwargs): pass
def ExpandEnvironmentStrings(*args, **kwargs): pass
def FlushKey(*args, **kwargs): pass

class PyHKEY(object):
	def Close(*args, **kwargs): pass
	def Detach(*args, **kwargs): pass
	def __abs__(*args, **kwargs): pass
	def __add__(*args, **kwargs): pass
	def __and__(*args, **kwargs): pass
	def __cmp__(*args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __div__(*args, **kwargs): pass
	def __divmod__(*args, **kwargs): pass
	def __doc__(*args, **kwargs): pass
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
	def __float__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __hex__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __int__(*args, **kwargs): pass
	def __invert__(*args, **kwargs): pass
	def __long__(*args, **kwargs): pass
	def __lshift__(*args, **kwargs): pass
	def __mod__(*args, **kwargs): pass
	def __mul__(*args, **kwargs): pass
	def __neg__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(*args, **kwargs): pass
	def __oct__(*args, **kwargs): pass
	def __or__(*args, **kwargs): pass
	def __pos__(*args, **kwargs): pass
	def __pow__(*args, **kwargs): pass
	def __radd__(*args, **kwargs): pass
	def __rand__(*args, **kwargs): pass
	def __rdiv__(*args, **kwargs): pass
	def __rdivmod__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __rlshift__(*args, **kwargs): pass
	def __rmod__(*args, **kwargs): pass
	def __rmul__(*args, **kwargs): pass
	def __ror__(*args, **kwargs): pass
	def __rpow__(*args, **kwargs): pass
	def __rrshift__(*args, **kwargs): pass
	def __rshift__(*args, **kwargs): pass
	def __rsub__(*args, **kwargs): pass
	def __rxor__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __sub__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __xor__(*args, **kwargs): pass
	handle = property(lambda self: None)

HKEY_CLASSES_ROOT = 18446744071562067968L
HKEY_CURRENT_CONFIG = 18446744071562067973L
HKEY_CURRENT_USER = 18446744071562067969L
HKEY_DYN_DATA = 18446744071562067974L
HKEY_LOCAL_MACHINE = 18446744071562067970L
HKEY_PERFORMANCE_DATA = 18446744071562067972L
HKEY_USERS = 18446744071562067971L
KEY_ALL_ACCESS = 983103
KEY_CREATE_LINK = 32
KEY_CREATE_SUB_KEY = 4
KEY_ENUMERATE_SUB_KEYS = 8
KEY_EXECUTE = 131097
KEY_NOTIFY = 16
KEY_QUERY_VALUE = 1
KEY_READ = 131097
KEY_SET_VALUE = 2
KEY_WOW64_32KEY = 512
KEY_WOW64_64KEY = 256
KEY_WRITE = 131078
def LoadKey(*args, **kwargs): pass
def OpenKey(*args, **kwargs): pass
def OpenKeyEx(*args, **kwargs): pass
def QueryInfoKey(*args, **kwargs): pass
def QueryReflectionKey(*args, **kwargs): pass
def QueryValue(*args, **kwargs): pass
def QueryValueEx(*args, **kwargs): pass
REG_BINARY = 3
REG_CREATED_NEW_KEY = 1
REG_DWORD = 4
REG_DWORD_BIG_ENDIAN = 5
REG_DWORD_LITTLE_ENDIAN = 4
REG_EXPAND_SZ = 2
REG_FULL_RESOURCE_DESCRIPTOR = 9
REG_LEGAL_CHANGE_FILTER = 268435471
REG_LEGAL_OPTION = 31
REG_LINK = 6
REG_MULTI_SZ = 7
REG_NONE = 0
REG_NOTIFY_CHANGE_ATTRIBUTES = 2
REG_NOTIFY_CHANGE_LAST_SET = 4
REG_NOTIFY_CHANGE_NAME = 1
REG_NOTIFY_CHANGE_SECURITY = 8
REG_NO_LAZY_FLUSH = 4
REG_OPENED_EXISTING_KEY = 2
REG_OPTION_BACKUP_RESTORE = 4
REG_OPTION_CREATE_LINK = 2
REG_OPTION_NON_VOLATILE = 0
REG_OPTION_OPEN_LINK = 8
REG_OPTION_RESERVED = 0
REG_OPTION_VOLATILE = 1
REG_REFRESH_HIVE = 2
REG_RESOURCE_LIST = 8
REG_RESOURCE_REQUIREMENTS_LIST = 10
REG_SZ = 1
REG_WHOLE_HIVE_VOLATILE = 1
def SaveKey(*args, **kwargs): pass
def SetValue(*args, **kwargs): pass
def SetValueEx(*args, **kwargs): pass
__doc__ = 'This module provides access to the Windows registry API.\n\nFunctions:\n\nCloseKey() - Closes a registry key.\nConnectRegistry() - Establishes a connection to a predefined registry handle\n                    on another computer.\nCreateKey() - Creates the specified key, or opens it if it already exists.\nDeleteKey() - Deletes the specified key.\nDeleteValue() - Removes a named value from the specified registry key.\nEnumKey() - Enumerates subkeys of the specified open registry key.\nEnumValue() - Enumerates values of the specified open registry key.\nExpandEnvironmentStrings() - Expand the env strings in a REG_EXPAND_SZ string.\nFlushKey() - Writes all the attributes of the specified key to the registry.\nLoadKey() - Creates a subkey under HKEY_USER or HKEY_LOCAL_MACHINE and stores\n            registration information from a specified file into that subkey.\nOpenKey() - Alias for <om win32api.RegOpenKeyEx>\nOpenKeyEx() - Opens the specified key.\nQueryValue() - Retrieves the value associated with the unnamed value for a\n               specified key in the registry.\nQueryValueEx() - Retrieves the type and data for a specified value name\n                 associated with an open registry key.\nQueryInfoKey() - Returns information about the specified key.\nSaveKey() - Saves the specified key, and all its subkeys a file.\nSetValue() - Associates a value with a specified key.\nSetValueEx() - Stores data in the value field of an open registry key.\n\nSpecial objects:\n\nHKEYType -- type object for HKEY objects\nerror -- exception raised for Win32 errors\n\nInteger constants:\nMany constants are defined - see the documentation for each function\nto see what constants are used, and where.'
__name__ = '_winreg'
__package__ = None

class BaseException(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Common base class for all exceptions'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	message = property(lambda self: None)


class Exception(BaseException):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Common base class for all non-exit exceptions.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	message = property(lambda self: None)


class StandardError(Exception):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Base class for all standard Python exceptions that do not represent\ninterpreter exiting.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	message = property(lambda self: None)


class EnvironmentError(StandardError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Base class for I/O related errors.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class OSError(EnvironmentError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'OS system call failed.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class WindowsError(OSError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'MS-Windows OS system call failed.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __unicode__(*args, **kwargs): pass
	args = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)
	winerror = property(lambda self: None)
