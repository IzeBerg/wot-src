# Stubs Generator
# import _Scaleform
# <module '_Scaleform' (built-in)>


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


class MovieDef(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = '_Scaleform'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MovieDef'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def createInstance(self, *args, **kwargs): pass


class MovieView(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattr__(self, *args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = '_Scaleform'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MovieView'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	backgroundAlpha = property(lambda self: None)
	def gotoFrame(self, *args, **kwargs): pass
	def gotoLabeledFrame(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseButtonEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def invoke(self, *args, **kwargs): pass
	movieUid = property(lambda self: None)
	def printObjectsReport(self, *args, **kwargs): pass
	def restart(self, *args, **kwargs): pass
	scaleMode = property(lambda self: None)
	def setExternalInterfaceCallback(self, *args, **kwargs): pass
	def setFocused(self, *args, **kwargs): pass
	def setPause(self, *args, **kwargs): pass
	userData = property(lambda self: None)
	visible = property(lambda self: None)


class PyGFxDisplayInfo(pybind11_object):
	FOV = property(lambda self: None)
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = '_Scaleform'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyGFxDisplayInfo'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	alpha = property(lambda self: None)
	def clear(self, *args, **kwargs): pass
	edgeAAMode = property(lambda self: None)
	position = property(lambda self: None)
	position3D = property(lambda self: None)
	projectionMatrix3D = property(lambda self: None)
	rotationDegrees = property(lambda self: None)
	scale = property(lambda self: None)
	scale3D = property(lambda self: None)
	viewMatrix3D = property(lambda self: None)
	visible = property(lambda self: None)
	x = property(lambda self: None)
	xRotation = property(lambda self: None)
	xScale = property(lambda self: None)
	y = property(lambda self: None)
	yRotation = property(lambda self: None)
	yScale = property(lambda self: None)
	z = property(lambda self: None)
	zScale = property(lambda self: None)


class PyGFxValue(pybind11_object):
	def __call__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__members__ = property(lambda self: None)
	__module__ = '_Scaleform'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyGFxValue'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	children = property(lambda self: None)
	def fromDict(self, *args, **kwargs): pass
	isDisplayObject = property(lambda self: None)
	isObjectOrMethod = property(lambda self: None)
	name = property(lambda self: None)
	def resync(self, *args, **kwargs): pass
	def resyncSelf(self, *args, **kwargs): pass
	def toDict(self, *args, **kwargs): pass


class PyGFxDisplayObject(PyGFxValue):
	def __call__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__members__ = property(lambda self: None)
	__module__ = '_Scaleform'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyGFxDisplayObject'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	children = property(lambda self: None)
	displayMatrix = property(lambda self: None)
	def fromDict(self, *args, **kwargs): pass
	def getDisplayInfo(self, *args, **kwargs): pass
	isDisplayObject = property(lambda self: None)
	isObjectOrMethod = property(lambda self: None)
	matrix3D = property(lambda self: None)
	name = property(lambda self: None)
	def resync(self, *args, **kwargs): pass
	def resyncSelf(self, *args, **kwargs): pass
	def setDisplayInfo(self, *args, **kwargs): pass
	text = property(lambda self: None)
	textHTML = property(lambda self: None)
	textHTMLUnicode = property(lambda self: None)
	textUnicode = property(lambda self: None)
	def toDict(self, *args, **kwargs): pass
	worldMatrix = property(lambda self: None)

__doc__ = None
__name__ = '_Scaleform'
__package__ = None