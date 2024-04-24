# Stubs Generator
# import _collections
# <module '_collections' (built-in)>

__doc__ = 'High performance data structures.\n- deque:        ordered collection accessible from endpoints only\n- defaultdict:  dict subclass with a default value factory\n'
__name__ = '_collections'
__package__ = None

class dict(object):
	def __cmp__(*args, **kwargs): pass
	def __contains__(*args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __delitem__(*args, **kwargs): pass
	__doc__ = "dict() -> new empty dictionary\ndict(mapping) -> new dictionary initialized from a mapping object's\n    (key, value) pairs\ndict(iterable) -> new dictionary initialized as if via:\n    d = {}\n    for k, v in iterable:\n        d[k] = v\ndict(**kwargs) -> new dictionary initialized with the name=value pairs\n    in the keyword argument list.  For example:  dict(one=1, two=2)"
	def __eq__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __ge__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __gt__(*args, **kwargs): pass
	__hash__ = None
	def __init__(*args, **kwargs): pass
	def __iter__(*args, **kwargs): pass
	def __le__(*args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	def __lt__(*args, **kwargs): pass
	def __ne__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def clear(*args, **kwargs): pass
	def copy(*args, **kwargs): pass
	def fromkeys(*args, **kwargs): pass
	def get(*args, **kwargs): pass
	def has_key(*args, **kwargs): pass
	def items(*args, **kwargs): pass
	def iteritems(*args, **kwargs): pass
	def iterkeys(*args, **kwargs): pass
	def itervalues(*args, **kwargs): pass
	def keys(*args, **kwargs): pass
	def pop(*args, **kwargs): pass
	def popitem(*args, **kwargs): pass
	def setdefault(*args, **kwargs): pass
	def update(*args, **kwargs): pass
	def values(*args, **kwargs): pass
	def viewitems(*args, **kwargs): pass
	def viewkeys(*args, **kwargs): pass
	def viewvalues(*args, **kwargs): pass


class defaultdict(dict):
	def __cmp__(*args, **kwargs): pass
	def __contains__(*args, **kwargs): pass
	def __copy__(*args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __delitem__(*args, **kwargs): pass
	__doc__ = 'defaultdict(default_factory[, ...]) --> dict with default factory\n\nThe default factory is called without arguments to produce\na new value when a key is not present, in __getitem__ only.\nA defaultdict compares equal to a dict with the same items.\nAll remaining arguments are treated the same as if they were\npassed to the dict constructor, including keyword arguments.\n'
	def __eq__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __ge__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __gt__(*args, **kwargs): pass
	__hash__ = None
	def __init__(*args, **kwargs): pass
	def __iter__(*args, **kwargs): pass
	def __le__(*args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	def __lt__(*args, **kwargs): pass
	def __missing__(*args, **kwargs): pass
	def __ne__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def clear(*args, **kwargs): pass
	def copy(*args, **kwargs): pass
	default_factory = property(lambda self: None)
	def fromkeys(*args, **kwargs): pass
	def get(*args, **kwargs): pass
	def has_key(*args, **kwargs): pass
	def items(*args, **kwargs): pass
	def iteritems(*args, **kwargs): pass
	def iterkeys(*args, **kwargs): pass
	def itervalues(*args, **kwargs): pass
	def keys(*args, **kwargs): pass
	def pop(*args, **kwargs): pass
	def popitem(*args, **kwargs): pass
	def setdefault(*args, **kwargs): pass
	def update(*args, **kwargs): pass
	def values(*args, **kwargs): pass
	def viewitems(*args, **kwargs): pass
	def viewkeys(*args, **kwargs): pass
	def viewvalues(*args, **kwargs): pass


class deque(object):
	def __copy__(*args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __delitem__(*args, **kwargs): pass
	__doc__ = 'deque([iterable[, maxlen]]) --> deque object\n\nBuild an ordered collection with optimized access from its endpoints.'
	def __eq__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __ge__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __gt__(*args, **kwargs): pass
	__hash__ = None
	def __iadd__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __iter__(*args, **kwargs): pass
	def __le__(*args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	def __lt__(*args, **kwargs): pass
	def __ne__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __reversed__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def append(*args, **kwargs): pass
	def appendleft(*args, **kwargs): pass
	def clear(*args, **kwargs): pass
	def count(*args, **kwargs): pass
	def extend(*args, **kwargs): pass
	def extendleft(*args, **kwargs): pass
	maxlen = property(lambda self: None)
	def pop(*args, **kwargs): pass
	def popleft(*args, **kwargs): pass
	def remove(*args, **kwargs): pass
	def reverse(*args, **kwargs): pass
	def rotate(*args, **kwargs): pass
