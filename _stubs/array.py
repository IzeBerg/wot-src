# Stubs Generator
# import array
# <module 'array' (built-in)>


class array(object):
	def __add__(*args, **kwargs): pass
	def __contains__(*args, **kwargs): pass
	def __copy__(*args, **kwargs): pass
	def __deepcopy__(*args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __delitem__(*args, **kwargs): pass
	def __delslice__(*args, **kwargs): pass
	__doc__ = 'array(typecode [, initializer]) -> array\n\nReturn a new array whose items are restricted by typecode, and\ninitialized from the optional initializer value, which must be a list,\nstring or iterable over elements of the appropriate type.\n\nArrays represent basic values and behave very much like lists, except\nthe type of objects stored in them is constrained.\n\nMethods:\n\nappend() -- append a new item to the end of the array\nbuffer_info() -- return information giving the current memory info\nbyteswap() -- byteswap all the items of the array\ncount() -- return number of occurrences of an object\nextend() -- extend array by appending multiple elements from an iterable\nfromfile() -- read items from a file object\nfromlist() -- append items from the list\nfromstring() -- append items from the string\nindex() -- return index of first occurrence of an object\ninsert() -- insert a new item into the array at a provided position\npop() -- remove and return item (default last)\nread() -- DEPRECATED, use fromfile()\nremove() -- remove first occurrence of an object\nreverse() -- reverse the order of the items in the array\ntofile() -- write all items to a file object\ntolist() -- return the array converted to an ordinary list\ntostring() -- return the array converted to a string\nwrite() -- DEPRECATED, use tofile()\n\nAttributes:\n\ntypecode -- the typecode character used to create the array\nitemsize -- the length in bytes of one array item\n'
	def __eq__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __ge__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __gt__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __iadd__(*args, **kwargs): pass
	def __imul__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __iter__(*args, **kwargs): pass
	def __le__(*args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	def __lt__(*args, **kwargs): pass
	def __mul__(*args, **kwargs): pass
	def __ne__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __rmul__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(*args, **kwargs): pass
	def __setslice__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def append(*args, **kwargs): pass
	def buffer_info(*args, **kwargs): pass
	def byteswap(*args, **kwargs): pass
	def count(*args, **kwargs): pass
	def extend(*args, **kwargs): pass
	def fromfile(*args, **kwargs): pass
	def fromlist(*args, **kwargs): pass
	def fromstring(*args, **kwargs): pass
	def fromunicode(*args, **kwargs): pass
	def index(*args, **kwargs): pass
	def insert(*args, **kwargs): pass
	itemsize = property(lambda self: None)
	def pop(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def remove(*args, **kwargs): pass
	def reverse(*args, **kwargs): pass
	def tofile(*args, **kwargs): pass
	def tolist(*args, **kwargs): pass
	def tostring(*args, **kwargs): pass
	def tounicode(*args, **kwargs): pass
	typecode = property(lambda self: None)
	def write(*args, **kwargs): pass

__doc__ = "This module defines an object type which can efficiently represent\nan array of basic values: characters, integers, floating point\nnumbers.  Arrays are sequence types and behave very much like lists,\nexcept that the type of objects stored in them is constrained.  The\ntype is specified at object creation time by using a type code, which\nis a single character.  The following type codes are defined:\n\n    Type code   C Type             Minimum size in bytes \n    'c'         character          1 \n    'b'         signed integer     1 \n    'B'         unsigned integer   1 \n    'u'         Unicode character  2 \n    'h'         signed integer     2 \n    'H'         unsigned integer   2 \n    'i'         signed integer     2 \n    'I'         unsigned integer   2 \n    'l'         signed integer     4 \n    'L'         unsigned integer   4 \n    'f'         floating point     4 \n    'd'         floating point     8 \n\nThe constructor is:\n\narray(typecode [, initializer]) -- create a new array\n"
__name__ = 'array'
__package__ = None