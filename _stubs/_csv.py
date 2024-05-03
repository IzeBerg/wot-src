# Stubs Generator
# import _csv
# <module '_csv' (built-in)>


class Dialect(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'CSV dialect\n\nThe Dialect type records CSV parsing and generation options.\n'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	delimiter = property(lambda self: None)
	doublequote = property(lambda self: None)
	escapechar = property(lambda self: None)
	lineterminator = property(lambda self: None)
	quotechar = property(lambda self: None)
	quoting = property(lambda self: None)
	skipinitialspace = property(lambda self: None)
	strict = property(lambda self: None)


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


class Error(Exception):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = '_csv'
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
	__weakref__ = property(lambda self: None)
	args = property(lambda self: None)
	message = property(lambda self: None)

QUOTE_ALL = 1
QUOTE_MINIMAL = 0
QUOTE_NONE = 3
QUOTE_NONNUMERIC = 2
__doc__ = 'CSV parsing and writing.\n\nThis module provides classes that assist in the reading and writing\nof Comma Separated Value (CSV) files, and implements the interface\ndescribed by PEP 305.  Although many CSV files are simple to parse,\nthe format is not formally defined by a stable specification and\nis subtle enough that parsing lines of a CSV file with something\nlike line.split(",") is bound to fail.  The module supports three\nbasic APIs: reading, writing, and registration of dialects.\n\n\nDIALECT REGISTRATION:\n\nReaders and writers support a dialect argument, which is a convenient\nhandle on a group of settings.  When the dialect argument is a string,\nit identifies one of the dialects previously registered with the module.\nIf it is a class or instance, the attributes of the argument are used as\nthe settings for the reader or writer:\n\n    class excel:\n        delimiter = \',\'\n        quotechar = \'"\'\n        escapechar = None\n        doublequote = True\n        skipinitialspace = False\n        lineterminator = \'\\r\\n\'\n        quoting = QUOTE_MINIMAL\n\nSETTINGS:\n\n    * quotechar - specifies a one-character string to use as the \n        quoting character.  It defaults to \'"\'.\n    * delimiter - specifies a one-character string to use as the \n        field separator.  It defaults to \',\'.\n    * skipinitialspace - specifies how to interpret whitespace which\n        immediately follows a delimiter.  It defaults to False, which\n        means that whitespace immediately following a delimiter is part\n        of the following field.\n    * lineterminator -  specifies the character sequence which should \n        terminate rows.\n    * quoting - controls when quotes should be generated by the writer.\n        It can take on any of the following module constants:\n\n        csv.QUOTE_MINIMAL means only when required, for example, when a\n            field contains either the quotechar or the delimiter\n        csv.QUOTE_ALL means that quotes are always placed around fields.\n        csv.QUOTE_NONNUMERIC means that quotes are always placed around\n            fields which do not parse as integers or floating point\n            numbers.\n        csv.QUOTE_NONE means that quotes are never placed around fields.\n    * escapechar - specifies a one-character string used to escape \n        the delimiter when quoting is set to QUOTE_NONE.\n    * doublequote - controls the handling of quotes inside fields.  When\n        True, two consecutive quotes are interpreted as one during read,\n        and when writing, each quote character embedded in the data is\n        written as two quotes\n'
__name__ = '_csv'
__package__ = None
__version__ = '1.0'
_dialects = {'excel': <_csv.Dialect object at 0x000000001BA6B8D0>, 'excel-tab': <_csv.Dialect object at 0x000000001BA6B900>}
def field_size_limit(*args, **kwargs): pass
def get_dialect(*args, **kwargs): pass
def list_dialects(*args, **kwargs): pass
def reader(*args, **kwargs): pass
def register_dialect(*args, **kwargs): pass
def unregister_dialect(*args, **kwargs): pass
def writer(*args, **kwargs): pass