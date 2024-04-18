# Stubs Generator
# import Compound
# <module 'Compound' (built-in)>


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


class CompoundModel(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'Compound'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CompoundModel'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def collide(self, *args, **kwargs): pass
	def containsAttachment(self, *args, **kwargs): pass
	def findPartHandleByNode(self, *args, **kwargs): pass
	def getBoundsForPart(self, *args, **kwargs): pass
	def getBoundsForRoot(self, *args, **kwargs): pass
	def getNodeNames(self, *args, **kwargs): pass
	def getPartGeometryLink(self, *args, **kwargs): pass
	def getWorldMatrixCalculator(self, *args, **kwargs): pass
	isInWorld = property(lambda self: None)
	def isValid(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	def node(self, *args, **kwargs): pass
	position = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	root = property(lambda self: None)
	def setPartBoundingBoxAttachNode(self, *args, **kwargs): pass
	def setPartProperties(self, *args, **kwargs): pass
	def setPartVisible(self, *args, **kwargs): pass
	def setPartVisibleByName(self, *args, **kwargs): pass
	def setupFashions(self, *args, **kwargs): pass
	skipColorPass = property(lambda self: None)
	skipShadowPass = property(lambda self: None)
	visible = property(lambda self: None)


class MatrixProvider(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MatrixProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class ModelNodeAdapter(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'Compound'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ModelNodeAdapter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def attach(self, *args, **kwargs): pass
	def detach(self, *args, **kwargs): pass
	isDangling = property(lambda self: None)
	local = property(lambda self: None)
	localMatrix = property(lambda self: None)
	position = property(lambda self: None)

__doc__ = None
__name__ = 'Compound'
__package__ = None