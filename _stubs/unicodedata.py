# Stubs Generator
# import unicodedata
# <module 'unicodedata' (built-in)>


class UCD(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
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
	def bidirectional(*args, **kwargs): pass
	def category(*args, **kwargs): pass
	def combining(*args, **kwargs): pass
	def decimal(*args, **kwargs): pass
	def decomposition(*args, **kwargs): pass
	def digit(*args, **kwargs): pass
	def east_asian_width(*args, **kwargs): pass
	def lookup(*args, **kwargs): pass
	def mirrored(*args, **kwargs): pass
	def name(*args, **kwargs): pass
	def normalize(*args, **kwargs): pass
	def numeric(*args, **kwargs): pass
	unidata_version = property(lambda self: None)

__doc__ = 'This module provides access to the Unicode Character Database which\ndefines character properties for all Unicode characters. The data in\nthis database is based on the UnicodeData.txt file version\n5.2.0 which is publically available from ftp://ftp.unicode.org/.\n\nThe module uses the same names and symbols as defined by the\nUnicodeData File Format 5.2.0 (see\nhttp://www.unicode.org/reports/tr44/tr44-4.html).'
__name__ = 'unicodedata'
__package__ = None
def bidirectional(*args, **kwargs): pass
def category(*args, **kwargs): pass
def combining(*args, **kwargs): pass
def decimal(*args, **kwargs): pass
def decomposition(*args, **kwargs): pass
def digit(*args, **kwargs): pass
def east_asian_width(*args, **kwargs): pass
def lookup(*args, **kwargs): pass
def mirrored(*args, **kwargs): pass
def name(*args, **kwargs): pass
def normalize(*args, **kwargs): pass
def numeric(*args, **kwargs): pass
ucd_3_2_0 = UCD()

class PyCapsule(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Capsule objects let you wrap a C "void *" pointer in a Python\nobject.  They\'re a way of passing data through the Python interpreter\nwithout creating your own custom type.\n\nCapsules are used for communication between extension modules.\nThey provide a way for an extension module to export a C interface\nto other extension modules, so that extension modules can use the\nPython import mechanism to link to one another.\n'
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

ucnhash_CAPI = PyCapsule()
unidata_version = '5.2.0'