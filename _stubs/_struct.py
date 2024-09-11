# Stubs Generator
# import _struct
# <module '_struct' (built-in)>


class Struct(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Compiled struct object'
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
	format = property(lambda self: None)
	def pack(*args, **kwargs): pass
	def pack_into(*args, **kwargs): pass
	size = property(lambda self: None)
	def unpack(*args, **kwargs): pass
	def unpack_from(*args, **kwargs): pass

_PY_STRUCT_FLOAT_COERCE = 1
_PY_STRUCT_RANGE_CHECKING = 1
__doc__ = "Functions to convert between Python values and C structs represented\nas Python strings. It uses format strings (explained below) as compact\ndescriptions of the lay-out of the C structs and the intended conversion\nto/from Python values.\n\nThe optional first format char indicates byte order, size and alignment:\n  @: native order, size & alignment (default)\n  =: native order, std. size & alignment\n  <: little-endian, std. size & alignment\n  >: big-endian, std. size & alignment\n  !: same as >\n\nThe remaining chars indicate types of args and must match exactly;\nthese can be preceded by a decimal repeat count:\n  x: pad byte (no data); c:char; b:signed byte; B:unsigned byte;\n  ?: _Bool (requires C99; if not available, char is used instead)\n  h:short; H:unsigned short; i:int; I:unsigned int;\n  l:long; L:unsigned long; f:float; d:double.\nSpecial cases (preceding decimal count indicates length):\n  s:string (array of char); p: pascal string (with count byte).\nSpecial case (only available in native format):\n  P:an integer type that is wide enough to hold a pointer.\nSpecial case (not in native mode unless 'long long' in platform C):\n  q:long long; Q:unsigned long long\nWhitespace between formats is ignored.\n\nThe variable struct.error is an exception raised on errors.\n"
__name__ = '_struct'
__package__ = None
__version__ = '0.2'
def _clearcache(*args, **kwargs): pass
def calcsize(*args, **kwargs): pass

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


class error(Exception):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'struct'
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

def pack(*args, **kwargs): pass
def pack_into(*args, **kwargs): pass
def unpack(*args, **kwargs): pass
def unpack_from(*args, **kwargs): pass