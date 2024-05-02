# Stubs Generator
# import zipimport
# <module 'zipimport' (built-in)>


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


class ImportError(StandardError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = "Import can't find module, or can't find name in module."
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


class ZipImportError(ImportError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'zipimport'
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

__doc__ = "zipimport provides support for importing Python modules from Zip archives.\n\nThis module exports three objects:\n- zipimporter: a class; its constructor takes a path to a Zip archive.\n- ZipImportError: exception raised by zipimporter objects. It's a\n  subclass of ImportError, so it can be caught as ImportError, too.\n- _zip_directory_cache: a dict, mapping archive paths to zip directory\n  info dicts, as used in zipimporter._files.\n\nIt is usually not needed to use the zipimport module explicitly; it is\nused by the builtin import mechanism for sys.path items that are paths\nto Zip archives."
__name__ = 'zipimport'
__package__ = None
_zip_directory_cache = {}

class zipimporter(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = "zipimporter(archivepath) -> zipimporter object\n\nCreate a new zipimporter instance. 'archivepath' must be a path to\na zipfile, or to a specific path inside a zipfile. For example, it can be\n'/tmp/myimport.zip', or '/tmp/myimport.zip/mydirectory', if mydirectory is a\nvalid directory inside the archive.\n\n'ZipImportError is raised if 'archivepath' doesn't point to a valid Zip\narchive.\n\nThe 'archive' attribute of zipimporter objects contains the name of the\nzipfile targeted."
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
	_files = property(lambda self: None)
	archive = property(lambda self: None)
	def find_module(*args, **kwargs): pass
	def get_code(*args, **kwargs): pass
	def get_data(*args, **kwargs): pass
	def get_filename(*args, **kwargs): pass
	def get_source(*args, **kwargs): pass
	def is_package(*args, **kwargs): pass
	def load_module(*args, **kwargs): pass
	prefix = property(lambda self: None)
