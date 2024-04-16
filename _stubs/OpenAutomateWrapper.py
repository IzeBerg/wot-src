# Stubs Generator
# import OpenAutomateWrapper
# <module 'OpenAutomateWrapper' (built-in)>

CMD_AUTO_DETECT = OACommandType.CMD_AUTO_DETECT
CMD_EXIT = OACommandType.CMD_EXIT
CMD_GET_ALL_OPTIONS = OACommandType.CMD_GET_ALL_OPTIONS
CMD_GET_BENCHMARKS = OACommandType.CMD_GET_BENCHMARKS
CMD_GET_CURRENT_OPTIONS = OACommandType.CMD_GET_CURRENT_OPTIONS
CMD_RESTART = OACommandType.CMD_RESTART
CMD_RUN = OACommandType.CMD_RUN
CMD_RUN_BENCHMARK = OACommandType.CMD_RUN_BENCHMARK
CMD_SET_OPTIONS = OACommandType.CMD_SET_OPTIONS
COMP_OP_EQUAL = eOAComparisonOpType.COMP_OP_EQUAL
COMP_OP_GREATER = eOAComparisonOpType.COMP_OP_GREATER
COMP_OP_GREATER_OR_EQUAL = eOAComparisonOpType.COMP_OP_GREATER_OR_EQUAL
COMP_OP_INVALID = eOAComparisonOpType.COMP_OP_INVALID
COMP_OP_LESS = eOAComparisonOpType.COMP_OP_LESS
COMP_OP_LESS_OR_EQUAL = eOAComparisonOpType.COMP_OP_LESS_OR_EQUAL
COMP_OP_NOT_EQUAL = eOAComparisonOpType.COMP_OP_NOT_EQUAL

class pybind11_object(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = u'pybind11_builtins'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'pybind11_object'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class CreateOACommandWrapper(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'OpenAutomateWrapper'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CreateOACommandWrapper'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	benchmark = property(lambda self: None)


class CreateOANamedOptionWrapper(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'OpenAutomateWrapper'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CreateOANamedOptionWrapper'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	comparisonOp = property(lambda self: None)
	dataType = property(lambda self: None)
	enumValue = property(lambda self: None)
	maxValueFloat = property(lambda self: None)
	maxValueInt = property(lambda self: None)
	minValueFloat = property(lambda self: None)
	minValueInt = property(lambda self: None)
	name = property(lambda self: None)
	numSteps = property(lambda self: None)
	parentName = property(lambda self: None)
	def setComparison(self, *args, **kwargs): pass


class CreateOAVersionStructWrapper(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'OpenAutomateWrapper'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CreateOAVersionStructWrapper'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	build = property(lambda self: None)
	custom = property(lambda self: None)
	major = property(lambda self: None)
	minor = property(lambda self: None)


class OACommandType(pybind11_object):
	CMD_AUTO_DETECT = OACommandType.CMD_AUTO_DETECT
	CMD_EXIT = OACommandType.CMD_EXIT
	CMD_GET_ALL_OPTIONS = OACommandType.CMD_GET_ALL_OPTIONS
	CMD_GET_BENCHMARKS = OACommandType.CMD_GET_BENCHMARKS
	CMD_GET_CURRENT_OPTIONS = OACommandType.CMD_GET_CURRENT_OPTIONS
	CMD_RESTART = OACommandType.CMD_RESTART
	CMD_RUN = OACommandType.CMD_RUN
	CMD_RUN_BENCHMARK = OACommandType.CMD_RUN_BENCHMARK
	CMD_SET_OPTIONS = OACommandType.CMD_SET_OPTIONS
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  CMD_SET_OPTIONS\n\n  CMD_RUN_BENCHMARK\n\n  CMD_GET_CURRENT_OPTIONS\n\n  CMD_GET_BENCHMARKS\n\n  CMD_GET_ALL_OPTIONS\n\n  CMD_EXIT\n\n  CMD_RUN\n\n  CMD_AUTO_DETECT\n\n  CMD_RESTART'
	__entries = {u'CMD_SET_OPTIONS': (OACommandType.CMD_SET_OPTIONS, None), u'CMD_RUN_BENCHMARK': (OACommandType.CMD_RUN_BENCHMARK, None), u'CMD_GET_CURRENT_OPTIONS': (OACommandType.CMD_GET_CURRENT_OPTIONS, None), u'CMD_GET_BENCHMARKS': (OACommandType.CMD_GET_BENCHMARKS, None), u'CMD_GET_ALL_OPTIONS': (OACommandType.CMD_GET_ALL_OPTIONS, None), u'CMD_EXIT': (OACommandType.CMD_EXIT, None), u'CMD_RUN': (OACommandType.CMD_RUN, None), u'CMD_AUTO_DETECT': (OACommandType.CMD_AUTO_DETECT, None), u'CMD_RESTART': (OACommandType.CMD_RESTART, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'CMD_SET_OPTIONS': OACommandType.CMD_SET_OPTIONS, u'CMD_AUTO_DETECT': OACommandType.CMD_AUTO_DETECT, u'CMD_GET_ALL_OPTIONS': OACommandType.CMD_GET_ALL_OPTIONS, u'CMD_GET_BENCHMARKS': OACommandType.CMD_GET_BENCHMARKS, u'CMD_RUN': OACommandType.CMD_RUN, u'CMD_RUN_BENCHMARK': OACommandType.CMD_RUN_BENCHMARK, u'CMD_GET_CURRENT_OPTIONS': OACommandType.CMD_GET_CURRENT_OPTIONS, u'CMD_RESTART': OACommandType.CMD_RESTART, u'CMD_EXIT': OACommandType.CMD_EXIT}
	__module__ = 'OpenAutomateWrapper'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'OACommandType'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)

TYPE_BOOL = eOAOptionDataType.TYPE_BOOL
TYPE_ENUM = eOAOptionDataType.TYPE_ENUM
TYPE_FLOAT = eOAOptionDataType.TYPE_FLOAT
TYPE_INT = eOAOptionDataType.TYPE_INT
TYPE_INVALID = eOAOptionDataType.TYPE_INVALID
TYPE_STRING = eOAOptionDataType.TYPE_STRING
__doc__ = None
__name__ = 'OpenAutomateWrapper'
__package__ = None
def bwOAAddBenchmark(*args, **kwargs): pass
def bwOAAddOption(*args, **kwargs): pass
def bwOAAddOptionValue(*args, **kwargs): pass
def bwOAAddResultValue(*args, **kwargs): pass
def bwOAEndBenchmark(*args, **kwargs): pass
def bwOAGetNextCommand(*args, **kwargs): pass
def bwOAInit(*args, **kwargs): pass
def bwOAPrepareForQuit(*args, **kwargs): pass
def bwOARegisterApp(*args, **kwargs): pass
def bwOAStartBenchmark(*args, **kwargs): pass

class eOAComparisonOpType(pybind11_object):
	COMP_OP_EQUAL = eOAComparisonOpType.COMP_OP_EQUAL
	COMP_OP_GREATER = eOAComparisonOpType.COMP_OP_GREATER
	COMP_OP_GREATER_OR_EQUAL = eOAComparisonOpType.COMP_OP_GREATER_OR_EQUAL
	COMP_OP_INVALID = eOAComparisonOpType.COMP_OP_INVALID
	COMP_OP_LESS = eOAComparisonOpType.COMP_OP_LESS
	COMP_OP_LESS_OR_EQUAL = eOAComparisonOpType.COMP_OP_LESS_OR_EQUAL
	COMP_OP_NOT_EQUAL = eOAComparisonOpType.COMP_OP_NOT_EQUAL
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  COMP_OP_NOT_EQUAL\n\n  COMP_OP_EQUAL\n\n  COMP_OP_INVALID\n\n  COMP_OP_LESS\n\n  COMP_OP_GREATER\n\n  COMP_OP_LESS_OR_EQUAL\n\n  COMP_OP_GREATER_OR_EQUAL'
	__entries = {u'COMP_OP_NOT_EQUAL': (eOAComparisonOpType.COMP_OP_NOT_EQUAL, None), u'COMP_OP_EQUAL': (eOAComparisonOpType.COMP_OP_EQUAL, None), u'COMP_OP_INVALID': (eOAComparisonOpType.COMP_OP_INVALID, None), u'COMP_OP_LESS': (eOAComparisonOpType.COMP_OP_LESS, None), u'COMP_OP_GREATER': (eOAComparisonOpType.COMP_OP_GREATER, None), u'COMP_OP_LESS_OR_EQUAL': (eOAComparisonOpType.COMP_OP_LESS_OR_EQUAL, None), u'COMP_OP_GREATER_OR_EQUAL': (eOAComparisonOpType.COMP_OP_GREATER_OR_EQUAL, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'COMP_OP_EQUAL': eOAComparisonOpType.COMP_OP_EQUAL, u'COMP_OP_INVALID': eOAComparisonOpType.COMP_OP_INVALID, u'COMP_OP_LESS': eOAComparisonOpType.COMP_OP_LESS, u'COMP_OP_NOT_EQUAL': eOAComparisonOpType.COMP_OP_NOT_EQUAL, u'COMP_OP_GREATER': eOAComparisonOpType.COMP_OP_GREATER, u'COMP_OP_LESS_OR_EQUAL': eOAComparisonOpType.COMP_OP_LESS_OR_EQUAL, u'COMP_OP_GREATER_OR_EQUAL': eOAComparisonOpType.COMP_OP_GREATER_OR_EQUAL}
	__module__ = 'OpenAutomateWrapper'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'eOAComparisonOpType'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


class eOAOptionDataType(pybind11_object):
	TYPE_BOOL = eOAOptionDataType.TYPE_BOOL
	TYPE_ENUM = eOAOptionDataType.TYPE_ENUM
	TYPE_FLOAT = eOAOptionDataType.TYPE_FLOAT
	TYPE_INT = eOAOptionDataType.TYPE_INT
	TYPE_INVALID = eOAOptionDataType.TYPE_INVALID
	TYPE_STRING = eOAOptionDataType.TYPE_STRING
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  TYPE_ENUM\n\n  TYPE_INT\n\n  TYPE_STRING\n\n  TYPE_INVALID\n\n  TYPE_FLOAT\n\n  TYPE_BOOL'
	__entries = {u'TYPE_ENUM': (eOAOptionDataType.TYPE_ENUM, None), u'TYPE_INT': (eOAOptionDataType.TYPE_INT, None), u'TYPE_STRING': (eOAOptionDataType.TYPE_STRING, None), u'TYPE_INVALID': (eOAOptionDataType.TYPE_INVALID, None), u'TYPE_FLOAT': (eOAOptionDataType.TYPE_FLOAT, None), u'TYPE_BOOL': (eOAOptionDataType.TYPE_BOOL, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'TYPE_ENUM': eOAOptionDataType.TYPE_ENUM, u'TYPE_INT': eOAOptionDataType.TYPE_INT, u'TYPE_STRING': eOAOptionDataType.TYPE_STRING, u'TYPE_INVALID': eOAOptionDataType.TYPE_INVALID, u'TYPE_FLOAT': eOAOptionDataType.TYPE_FLOAT, u'TYPE_BOOL': eOAOptionDataType.TYPE_BOOL}
	__module__ = 'OpenAutomateWrapper'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'eOAOptionDataType'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)

def getOpenAutomateArgument(*args, **kwargs): pass
def getOpenAutomateTestArgument(*args, **kwargs): pass