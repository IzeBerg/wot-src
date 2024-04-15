# Stubs Generator
# import imp
# <module 'imp' (built-in)>

C_BUILTIN = 6
C_EXTENSION = 3
IMP_HOOK = 9

class NullImporter(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Null importer object'
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
	def find_module(*args, **kwargs): pass

PKG_DIRECTORY = 5
PY_CODERESOURCE = 8
PY_COMPILED = 2
PY_FROZEN = 7
PY_RESOURCE = 4
PY_SOURCE = 1
SEARCH_ERROR = 0
__doc__ = 'This module provides the components needed to build your own\n__import__ function.  Undocumented functions are obsolete.'
__name__ = 'imp'
__package__ = None
def acquire_lock(*args, **kwargs): pass
def find_module(*args, **kwargs): pass
def get_frozen_object(*args, **kwargs): pass
def get_magic(*args, **kwargs): pass
def get_suffixes(*args, **kwargs): pass
def init_builtin(*args, **kwargs): pass
def init_frozen(*args, **kwargs): pass
def is_builtin(*args, **kwargs): pass
def is_frozen(*args, **kwargs): pass
def load_compiled(*args, **kwargs): pass
def load_dynamic(*args, **kwargs): pass
def load_module(*args, **kwargs): pass
def load_package(*args, **kwargs): pass
def load_source(*args, **kwargs): pass
def lock_held(*args, **kwargs): pass
def new_module(*args, **kwargs): pass
def release_lock(*args, **kwargs): pass
def reload(*args, **kwargs): pass