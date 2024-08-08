# Stubs Generator
# import datetime
# <module 'datetime' (built-in)>

MAXYEAR = 9999
MINYEAR = 1
__doc__ = 'Fast implementation of the datetime type.'
__name__ = 'datetime'
__package__ = None

class date(object):
	def __add__(*args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'date(year, month, day) --> date object'
	def __eq__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __ge__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __gt__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __le__(*args, **kwargs): pass
	def __lt__(*args, **kwargs): pass
	def __ne__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __radd__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __rsub__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __sub__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def ctime(*args, **kwargs): pass
	day = property(lambda self: None)
	def fromordinal(*args, **kwargs): pass
	def fromtimestamp(*args, **kwargs): pass
	def isocalendar(*args, **kwargs): pass
	def isoformat(*args, **kwargs): pass
	def isoweekday(*args, **kwargs): pass
	max = datetime.date(9999, 12, 31)
	min = datetime.date(1, 1, 1)
	month = property(lambda self: None)
	def replace(*args, **kwargs): pass
	resolution = datetime.timedelta(1)
	def strftime(*args, **kwargs): pass
	def timetuple(*args, **kwargs): pass
	def today(*args, **kwargs): pass
	def toordinal(*args, **kwargs): pass
	def weekday(*args, **kwargs): pass
	year = property(lambda self: None)


class datetime(date):
	def __add__(*args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'datetime(year, month, day[, hour[, minute[, second[, microsecond[,tzinfo]]]]])\n\nThe year, month and day arguments are required. tzinfo may be None, or an\ninstance of a tzinfo subclass. The remaining arguments may be ints or longs.\n'
	def __eq__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __ge__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __gt__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __le__(*args, **kwargs): pass
	def __lt__(*args, **kwargs): pass
	def __ne__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __radd__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __rsub__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __sub__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def astimezone(*args, **kwargs): pass
	def combine(*args, **kwargs): pass
	def ctime(*args, **kwargs): pass
	def date(*args, **kwargs): pass
	day = property(lambda self: None)
	def dst(*args, **kwargs): pass
	def fromordinal(*args, **kwargs): pass
	def fromtimestamp(*args, **kwargs): pass
	hour = property(lambda self: None)
	def isocalendar(*args, **kwargs): pass
	def isoformat(*args, **kwargs): pass
	def isoweekday(*args, **kwargs): pass
	max = datetime.datetime(9999, 12, 31, 23, 59, 59, 999999)
	microsecond = property(lambda self: None)
	min = datetime.datetime(1, 1, 1, 0, 0)
	minute = property(lambda self: None)
	month = property(lambda self: None)
	def now(*args, **kwargs): pass
	def replace(*args, **kwargs): pass
	resolution = datetime.timedelta(0, 0, 1)
	second = property(lambda self: None)
	def strftime(*args, **kwargs): pass
	def strptime(*args, **kwargs): pass
	def time(*args, **kwargs): pass
	def timetuple(*args, **kwargs): pass
	def timetz(*args, **kwargs): pass
	def today(*args, **kwargs): pass
	def toordinal(*args, **kwargs): pass
	tzinfo = property(lambda self: None)
	def tzname(*args, **kwargs): pass
	def utcfromtimestamp(*args, **kwargs): pass
	def utcnow(*args, **kwargs): pass
	def utcoffset(*args, **kwargs): pass
	def utctimetuple(*args, **kwargs): pass
	def weekday(*args, **kwargs): pass
	year = property(lambda self: None)


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

datetime_CAPI = PyCapsule()

class time(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'time([hour[, minute[, second[, microsecond[, tzinfo]]]]]) --> a time object\n\nAll arguments are optional. tzinfo may be None, or an instance of\na tzinfo subclass. The remaining arguments may be ints or longs.\n'
	def __eq__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __ge__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __gt__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __le__(*args, **kwargs): pass
	def __lt__(*args, **kwargs): pass
	def __ne__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def dst(*args, **kwargs): pass
	hour = property(lambda self: None)
	def isoformat(*args, **kwargs): pass
	max = datetime.time(23, 59, 59, 999999)
	microsecond = property(lambda self: None)
	min = datetime.time(0, 0)
	minute = property(lambda self: None)
	def replace(*args, **kwargs): pass
	resolution = datetime.timedelta(0, 0, 1)
	second = property(lambda self: None)
	def strftime(*args, **kwargs): pass
	tzinfo = property(lambda self: None)
	def tzname(*args, **kwargs): pass
	def utcoffset(*args, **kwargs): pass


class timedelta(object):
	def __abs__(*args, **kwargs): pass
	def __add__(*args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __div__(*args, **kwargs): pass
	__doc__ = 'Difference between two datetime values.'
	def __eq__(*args, **kwargs): pass
	def __floordiv__(*args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __ge__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __gt__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __le__(*args, **kwargs): pass
	def __lt__(*args, **kwargs): pass
	def __mul__(*args, **kwargs): pass
	def __ne__(*args, **kwargs): pass
	def __neg__(*args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(*args, **kwargs): pass
	def __pos__(*args, **kwargs): pass
	def __radd__(*args, **kwargs): pass
	def __rdiv__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __rfloordiv__(*args, **kwargs): pass
	def __rmul__(*args, **kwargs): pass
	def __rsub__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __sub__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	days = property(lambda self: None)
	max = datetime.timedelta(999999999, 86399, 999999)
	microseconds = property(lambda self: None)
	min = datetime.timedelta(-999999999)
	resolution = datetime.timedelta(0, 0, 1)
	seconds = property(lambda self: None)
	def total_seconds(*args, **kwargs): pass


class tzinfo(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = 'Abstract base class for time zone info objects.'
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
	def dst(*args, **kwargs): pass
	def fromutc(*args, **kwargs): pass
	def tzname(*args, **kwargs): pass
	def utcoffset(*args, **kwargs): pass
