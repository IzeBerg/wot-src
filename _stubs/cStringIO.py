# Stubs Generator
# import cStringIO
# <module 'cStringIO' (built-in)>


class StringI(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Simple type for treating strings as input file streams'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __iter__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def flush(*args, **kwargs): pass
	def getvalue(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	def next(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def reset(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass


class StringO(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Simple type for output to strings.'
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __iter__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def flush(*args, **kwargs): pass
	def getvalue(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	def next(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def reset(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	softspace = property(lambda self: None)
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass

def StringIO(*args, **kwargs): pass
__doc__ = 'A simple fast partial StringIO replacement.\n\nThis module provides a simple useful replacement for\nthe StringIO module that is written in C.  It does not provide the\nfull generality of StringIO, but it provides enough for most\napplications and is especially useful in conjunction with the\npickle module.\n\nUsage:\n\n  from cStringIO import StringIO\n\n  an_output_stream=StringIO()\n  an_output_stream.write(some_stuff)\n  ...\n  value=an_output_stream.getvalue()\n\n  an_input_stream=StringIO(a_string)\n  spam=an_input_stream.readline()\n  spam=an_input_stream.read(5)\n  an_input_stream.seek(0)           # OK, start over\n  spam=an_input_stream.read()       # and read it all\n  \nIf someone else wants to provide a more complete implementation,\ngo for it. :-)  \n\ncStringIO.c,v 1.29 1999/06/15 14:10:27 jim Exp\n'
__name__ = 'cStringIO'
__package__ = None

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

cStringIO_CAPI = PyCapsule()