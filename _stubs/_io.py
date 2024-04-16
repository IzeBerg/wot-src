# Stubs Generator
# import _io
# <module '_io' (built-in)>


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


class IOError(EnvironmentError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'I/O operation failed.'
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


class BlockingIOError(IOError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Exception raised when I/O would block on a non-blocking I/O stream'
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
	characters_written = property(lambda self: None)
	errno = property(lambda self: None)
	filename = property(lambda self: None)
	message = property(lambda self: None)
	strerror = property(lambda self: None)


class _IOBase(object):
	def __delattr__(*args, **kwargs): pass
	def __doc__(*args, **kwargs): pass
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
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
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	def next(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class _BufferedIOBase(_IOBase):
	def __delattr__(*args, **kwargs): pass
	def __doc__(*args, **kwargs): pass
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
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
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def detach(*args, **kwargs): pass
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	def next(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def read1(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readinto(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class BufferedRWPair(_BufferedIOBase):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'A buffered reader and writer object together.\n\nA buffered reader object and buffered writer object put together to\nform a sequential IO object that can read and write. This is typically\nused with a socket or two-way pipe.\n\nreader and writer are RawIOBase objects that are readable and\nwriteable respectively. If the buffer_size is omitted it defaults to\nDEFAULT_BUFFER_SIZE.\n'
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
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
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def detach(*args, **kwargs): pass
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	def next(*args, **kwargs): pass
	def peek(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def read1(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readinto(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class BufferedRandom(_BufferedIOBase):
	def __delattr__(*args, **kwargs): pass
	__doc__ = "A buffered interface to random access streams.\n\nThe constructor creates a reader and writer for a seekable stream,\nraw, given in the first argument. If the buffer_size is omitted it\ndefaults to DEFAULT_BUFFER_SIZE. max_buffer_size isn't used anymore.\n"
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
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
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def detach(*args, **kwargs): pass
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	mode = property(lambda self: None)
	name = property(lambda self: None)
	def next(*args, **kwargs): pass
	def peek(*args, **kwargs): pass
	raw = property(lambda self: None)
	def read(*args, **kwargs): pass
	def read1(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readinto(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class BufferedReader(_BufferedIOBase):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Create a new buffered reader using the given readable raw IO object.'
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
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
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def detach(*args, **kwargs): pass
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	mode = property(lambda self: None)
	name = property(lambda self: None)
	def next(*args, **kwargs): pass
	def peek(*args, **kwargs): pass
	raw = property(lambda self: None)
	def read(*args, **kwargs): pass
	def read1(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readinto(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class BufferedWriter(_BufferedIOBase):
	def __delattr__(*args, **kwargs): pass
	__doc__ = "A buffer for a writeable sequential RawIO object.\n\nThe constructor creates a BufferedWriter for the given writeable raw\nstream. If the buffer_size is not given, it defaults to\nDEFAULT_BUFFER_SIZE. max_buffer_size isn't used anymore.\n"
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
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
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def detach(*args, **kwargs): pass
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	mode = property(lambda self: None)
	name = property(lambda self: None)
	def next(*args, **kwargs): pass
	raw = property(lambda self: None)
	def read(*args, **kwargs): pass
	def read1(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readinto(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class BytesIO(_BufferedIOBase):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'BytesIO([buffer]) -> object\n\nCreate a buffered I/O implementation using an in-memory bytes\nbuffer, ready for reading and writing.'
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __iter__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def detach(*args, **kwargs): pass
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def getvalue(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	def next(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def read1(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readinto(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass

DEFAULT_BUFFER_SIZE = 8192

class _RawIOBase(_IOBase):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Base class for raw binary I/O.'
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
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
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	def next(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readall(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class FileIO(_RawIOBase):
	def __delattr__(*args, **kwargs): pass
	__doc__ = "file(name: str[, mode: str]) -> file IO object\n\nOpen a file.  The mode can be 'r' (default), 'w' or 'a' for reading,\nwriting or appending.  The file will be created if it doesn't exist\nwhen opened for writing or appending; it will be truncated when\nopened for writing.  Add a '+' to the mode to allow simultaneous\nreading and writing."
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
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
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	closefd = property(lambda self: None)
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	mode = property(lambda self: None)
	def next(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readall(*args, **kwargs): pass
	def readinto(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class IncrementalNewlineDecoder(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Codec used when reading a file in universal newlines mode.  It wraps\nanother incremental decoder, translating \\r\\n and \\r into \\n.  It also\nrecords the types of newlines encountered.  When used with\ntranslate=False, it ensures that the newline sequence is returned in\none piece. When used with decoder=None, it expects unicode strings as\ndecode input and translates newlines without first invoking an external\ndecoder.\n'
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
	def decode(*args, **kwargs): pass
	def getstate(*args, **kwargs): pass
	newlines = property(lambda self: None)
	def reset(*args, **kwargs): pass
	def setstate(*args, **kwargs): pass


class _TextIOBase(_IOBase):
	def __delattr__(*args, **kwargs): pass
	def __doc__(*args, **kwargs): pass
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
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
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def detach(*args, **kwargs): pass
	encoding = property(lambda self: None)
	errors = property(lambda self: None)
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	newlines = property(lambda self: None)
	def next(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class StringIO(_TextIOBase):
	def __delattr__(*args, **kwargs): pass
	__doc__ = "Text I/O implementation using an in-memory buffer.\n\nThe initial_value argument sets the value of object.  The newline\nargument is like the one of TextIOWrapper's constructor."
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __iter__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def detach(*args, **kwargs): pass
	encoding = property(lambda self: None)
	errors = property(lambda self: None)
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def getvalue(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	line_buffering = property(lambda self: None)
	newlines = property(lambda self: None)
	def next(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class TextIOWrapper(_TextIOBase):
	_CHUNK_SIZE = property(lambda self: None)
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Character and line based layer over a BufferedIOBase object, buffer.\n\nencoding gives the name of the encoding that the stream will be\ndecoded or encoded with. It defaults to locale.getpreferredencoding.\n\nerrors determines the strictness of encoding and decoding (see the\ncodecs.register) and defaults to "strict".\n\nnewline controls how line endings are handled. It can be None, \'\',\n\'\\n\', \'\\r\', and \'\\r\\n\'.  It works as follows:\n\n* On input, if newline is None, universal newlines mode is\n  enabled. Lines in the input can end in \'\\n\', \'\\r\', or \'\\r\\n\', and\n  these are translated into \'\\n\' before being returned to the\n  caller. If it is \'\', universal newline mode is enabled, but line\n  endings are returned to the caller untranslated. If it has any of\n  the other legal values, input lines are only terminated by the given\n  string, and the line ending is returned to the caller untranslated.\n\n* On output, if newline is None, any \'\\n\' characters written are\n  translated to the system default line separator, os.linesep. If\n  newline is \'\', no translation takes place. If newline is any of the\n  other legal values, any \'\\n\' characters written are translated to\n  the given string.\n\nIf line_buffering is True, a call to flush is implied when a call to\nwrite contains a newline character.'
	def __enter__(*args, **kwargs): pass
	def __exit__(*args, **kwargs): pass
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
	def _checkClosed(*args, **kwargs): pass
	def _checkReadable(*args, **kwargs): pass
	def _checkSeekable(*args, **kwargs): pass
	def _checkWritable(*args, **kwargs): pass
	buffer = property(lambda self: None)
	def close(*args, **kwargs): pass
	closed = property(lambda self: None)
	def detach(*args, **kwargs): pass
	encoding = property(lambda self: None)
	errors = property(lambda self: None)
	def fileno(*args, **kwargs): pass
	def flush(*args, **kwargs): pass
	def isatty(*args, **kwargs): pass
	line_buffering = property(lambda self: None)
	name = property(lambda self: None)
	newlines = property(lambda self: None)
	def next(*args, **kwargs): pass
	def read(*args, **kwargs): pass
	def readable(*args, **kwargs): pass
	def readline(*args, **kwargs): pass
	def readlines(*args, **kwargs): pass
	def seek(*args, **kwargs): pass
	def seekable(*args, **kwargs): pass
	def tell(*args, **kwargs): pass
	def truncate(*args, **kwargs): pass
	def writable(*args, **kwargs): pass
	def write(*args, **kwargs): pass
	def writelines(*args, **kwargs): pass


class ValueError(StandardError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Inappropriate argument value (of correct type).'
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


class UnsupportedOperation(IOError, ValueError):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'io'
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

__doc__ = "The io module provides the Python interfaces to stream handling. The\nbuiltin open function is defined in this module.\n\nAt the top of the I/O hierarchy is the abstract base class IOBase. It\ndefines the basic interface to a stream. Note, however, that there is no\nseparation between reading and writing to streams; implementations are\nallowed to raise an IOError if they do not support a given operation.\n\nExtending IOBase is RawIOBase which deals simply with the reading and\nwriting of raw bytes to a stream. FileIO subclasses RawIOBase to provide\nan interface to OS files.\n\nBufferedIOBase deals with buffering on a raw byte stream (RawIOBase). Its\nsubclasses, BufferedWriter, BufferedReader, and BufferedRWPair buffer\nstreams that are readable, writable, and both respectively.\nBufferedRandom provides a buffered interface to random access\nstreams. BytesIO is a simple stream of in-memory bytes.\n\nAnother IOBase subclass, TextIOBase, deals with the encoding and decoding\nof streams into text. TextIOWrapper, which extends it, is a buffered text\ninterface to a buffered raw stream (`BufferedIOBase`). Finally, StringIO\nis an in-memory stream for text.\n\nArgument names are not part of the specification, and only the arguments\nof open() are intended to be used as keyword arguments.\n\ndata:\n\nDEFAULT_BUFFER_SIZE\n\n   An int containing the default buffer size used by the module's buffered\n   I/O classes. open() uses the file's blksize (as obtained by os.stat) if\n   possible.\n"
__name__ = '_io'
__package__ = None
def open(*args, **kwargs): pass