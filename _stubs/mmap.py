# Stubs Generator
# import mmap
# <module 'mmap' (built-in)>

ACCESS_COPY = 3
ACCESS_READ = 1
ACCESS_WRITE = 2
ALLOCATIONGRANULARITY = 65536
PAGESIZE = 4096
__doc__ = None
__name__ = 'mmap'
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


class error(EnvironmentError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'mmap'
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
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class mmap(object):
	def __delattr__(*args, **kwargs): pass
	def __delitem__(*args, **kwargs): pass
	def __delslice__(*args, **kwargs): pass
	__doc__ = "Windows: mmap(fileno, length[, tagname[, access[, offset]]])\n\nMaps length bytes from the file specified by the file handle fileno,\nand returns a mmap object.  If length is larger than the current size\nof the file, the file is extended to contain length bytes.  If length\nis 0, the maximum length of the map is the current size of the file,\nexcept that if the file is empty Windows raises an exception (you cannot\ncreate an empty mapping on Windows).\n\nUnix: mmap(fileno, length[, flags[, prot[, access[, offset]]]])\n\nMaps length bytes from the file specified by the file descriptor fileno,\nand returns a mmap object.  If length is 0, the maximum length of the map\nwill be the current size of the file when mmap is called.\nflags specifies the nature of the mapping. MAP_PRIVATE creates a\nprivate copy-on-write mapping, so changes to the contents of the mmap\nobject will be private to this process, and MAP_SHARED creates a mapping\nthat's shared with all other processes mapping the same areas of the file.\nThe default value is MAP_SHARED.\n\nTo map anonymous memory, pass -1 as the fileno (both versions)."
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(*args, **kwargs): pass
	def __setslice__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	def find(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def move(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def read_byte(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def resize(*args, **kwargs): pass
	def rfind(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def size(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def write_byte(*args, **kwargs): pass
