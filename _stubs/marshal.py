# Stubs Generator
# import marshal
# <module 'marshal' (built-in)>

__doc__ = 'This module contains functions that can read and write Python values in\na binary format. The format is specific to Python, but independent of\nmachine architecture issues.\n\nNot all Python object types are supported; in general, only objects\nwhose value is independent from a particular invocation of Python can be\nwritten and read by this module. The following types are supported:\nNone, integers, long integers, floating point numbers, strings, Unicode\nobjects, tuples, lists, sets, dictionaries, and code objects, where it\nshould be understood that tuples, lists and dictionaries are only\nsupported as long as the values contained therein are themselves\nsupported; and recursive lists and dictionaries should not be written\n(they will cause infinite loops).\n\nVariables:\n\nversion -- indicates the format that the module uses. Version 0 is the\n    historical format, version 1 (added in Python 2.4) shares interned\n    strings and version 2 (added in Python 2.5) uses a binary format for\n    floating point numbers. (New in version 2.4)\n\nFunctions:\n\ndump() -- write value to a file\nload() -- read value from a file\ndumps() -- write value to a string\nloads() -- read value from a string'
__name__ = 'marshal'
__package__ = None
def dump(*args, **kwargs): pass
def dumps(*args, **kwargs): pass
def load(*args, **kwargs): pass
def loads(*args, **kwargs): pass
version = 2