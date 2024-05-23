# Stubs Generator
# import GUI
# <module 'GUI' (built-in)>


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


class AABB(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'AABB'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	absoluteSubspace = property(lambda self: None)
	alwaysDisplayChildren = property(lambda self: None)
	clipSpaceSource = property(lambda self: None)
	clipToBox = property(lambda self: None)
	offsetSubspace = property(lambda self: None)
	source = property(lambda self: None)


class PyAttachment(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyAttachment'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	attached = property(lambda self: None)
	castsShadow = property(lambda self: None)
	inWorld = property(lambda self: None)
	matrix = property(lambda self: None)


class Attachment(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Attachment'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	attached = property(lambda self: None)
	castsShadow = property(lambda self: None)
	component = property(lambda self: None)
	faceCamera = property(lambda self: None)
	inWorld = property(lambda self: None)
	matrix = property(lambda self: None)


class GUIShader(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'GUIShader'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class ClipShader(GUIShader):
	CLIP_DOWN = Mode.CLIP_DOWN
	CLIP_LEFT = Mode.CLIP_LEFT
	CLIP_RIGHT = Mode.CLIP_RIGHT
	CLIP_UP = Mode.CLIP_UP
	
	class Mode(pybind11_object):
		CLIP_DOWN = Mode.CLIP_DOWN
		CLIP_LEFT = Mode.CLIP_LEFT
		CLIP_RIGHT = Mode.CLIP_RIGHT
		CLIP_UP = Mode.CLIP_UP
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  CLIP_RIGHT\n\n  CLIP_DOWN\n\n  CLIP_UP\n\n  CLIP_LEFT'
		__entries = {u'CLIP_RIGHT': (Mode.CLIP_RIGHT, None), u'CLIP_DOWN': (Mode.CLIP_DOWN, None), u'CLIP_UP': (Mode.CLIP_UP, None), u'CLIP_LEFT': (Mode.CLIP_LEFT, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'CLIP_RIGHT': Mode.CLIP_RIGHT, u'CLIP_DOWN': Mode.CLIP_DOWN, u'CLIP_UP': Mode.CLIP_UP, u'CLIP_LEFT': Mode.CLIP_LEFT}
		__module__ = 'GUI'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'ClipShader.Mode'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ClipShader'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	currentValue = property(lambda self: None)
	delay = property(lambda self: None)
	dynElement = property(lambda self: None)
	dynValue = property(lambda self: None)
	mode = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	slant = property(lambda self: None)
	speed = property(lambda self: None)
	value = property(lambda self: None)


class ColourShader(GUIShader):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ColourShader'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	colourProvider = property(lambda self: None)
	currentValue = property(lambda self: None)
	end = property(lambda self: None)
	middle = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	start = property(lambda self: None)
	value = property(lambda self: None)


class Simple(pybind11_object):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Simple'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	
	class eFilterType(pybind11_object):
		LINEAR = eFilterType.LINEAR
		NONE = eFilterType.NONE
		POINT = eFilterType.POINT
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  LINEAR\n\n  NONE\n\n  POINT'
		__entries = {u'LINEAR': (eFilterType.LINEAR, None), u'NONE': (eFilterType.NONE, None), u'POINT': (eFilterType.POINT, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'LINEAR': eFilterType.LINEAR, u'NONE': eFilterType.NONE, u'POINT': eFilterType.POINT}
		__module__ = 'GUI'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'Simple.eFilterType'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	
	class eHAnchor(pybind11_object):
		CENTER = eHAnchor.CENTER
		LEFT = eHAnchor.LEFT
		RIGHT = eHAnchor.RIGHT
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  CENTER\n\n  RIGHT\n\n  LEFT'
		__entries = {u'CENTER': (eHAnchor.CENTER, None), u'RIGHT': (eHAnchor.RIGHT, None), u'LEFT': (eHAnchor.LEFT, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'CENTER': eHAnchor.CENTER, u'LEFT': eHAnchor.LEFT, u'RIGHT': eHAnchor.RIGHT}
		__module__ = 'GUI'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'Simple.eHAnchor'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	
	class eMaterialFX(pybind11_object):
		ADD = eMaterialFX.ADD
		ADD_SIGNED = eMaterialFX.ADD_SIGNED
		ALPHA_TEST = eMaterialFX.ALPHA_TEST
		BLEND = eMaterialFX.BLEND
		BLEND2X = eMaterialFX.BLEND2X
		BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
		BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
		BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
		MODULATE2X = eMaterialFX.MODULATE2X
		SOLID = eMaterialFX.SOLID
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  ADD\n\n  BLEND_INVERSE_COLOUR\n\n  BLEND2X\n\n  MODULATE2X\n\n  ALPHA_TEST\n\n  SOLID\n\n  BLEND\n\n  BLEND_COLOUR\n\n  BLEND_INVERSE_ALPHA\n\n  ADD_SIGNED'
		__entries = {u'ADD': (eMaterialFX.ADD, None), u'BLEND_INVERSE_COLOUR': (eMaterialFX.BLEND_INVERSE_COLOUR, None), u'BLEND2X': (eMaterialFX.BLEND2X, None), u'MODULATE2X': (eMaterialFX.MODULATE2X, None), u'ALPHA_TEST': (eMaterialFX.ALPHA_TEST, None), u'SOLID': (eMaterialFX.SOLID, None), u'BLEND': (eMaterialFX.BLEND, None), u'BLEND_COLOUR': (eMaterialFX.BLEND_COLOUR, None), u'BLEND_INVERSE_ALPHA': (eMaterialFX.BLEND_INVERSE_ALPHA, None), u'ADD_SIGNED': (eMaterialFX.ADD_SIGNED, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'ADD': eMaterialFX.ADD, u'BLEND_INVERSE_COLOUR': eMaterialFX.BLEND_INVERSE_COLOUR, u'BLEND2X': eMaterialFX.BLEND2X, u'MODULATE2X': eMaterialFX.MODULATE2X, u'BLEND_COLOUR': eMaterialFX.BLEND_COLOUR, u'SOLID': eMaterialFX.SOLID, u'ALPHA_TEST': eMaterialFX.ALPHA_TEST, u'BLEND': eMaterialFX.BLEND, u'BLEND_INVERSE_ALPHA': eMaterialFX.BLEND_INVERSE_ALPHA, u'ADD_SIGNED': eMaterialFX.ADD_SIGNED}
		__module__ = 'GUI'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'Simple.eMaterialFX'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	
	class ePositionMode(pybind11_object):
		CLIP = ePositionMode.CLIP
		LEGACY = ePositionMode.LEGACY
		PIXEL = ePositionMode.PIXEL
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  PIXEL\n\n  CLIP\n\n  LEGACY'
		__entries = {u'PIXEL': (ePositionMode.PIXEL, None), u'CLIP': (ePositionMode.CLIP, None), u'LEGACY': (ePositionMode.LEGACY, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'PIXEL': ePositionMode.PIXEL, u'CLIP': ePositionMode.CLIP, u'LEGACY': ePositionMode.LEGACY}
		__module__ = 'GUI'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'Simple.ePositionMode'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	
	class eSizeMode(pybind11_object):
		CLIP = eSizeMode.CLIP
		LEGACY = eSizeMode.LEGACY
		PIXEL = eSizeMode.PIXEL
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  PIXEL\n\n  CLIP\n\n  LEGACY'
		__entries = {u'PIXEL': (eSizeMode.PIXEL, None), u'CLIP': (eSizeMode.CLIP, None), u'LEGACY': (eSizeMode.LEGACY, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'PIXEL': eSizeMode.PIXEL, u'CLIP': eSizeMode.CLIP, u'LEGACY': eSizeMode.LEGACY}
		__module__ = 'GUI'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'Simple.eSizeMode'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	
	class eVAnchor(pybind11_object):
		BOTTOM = eVAnchor.BOTTOM
		CENTER = eVAnchor.CENTER
		TOP = eVAnchor.TOP
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  CENTER\n\n  TOP\n\n  BOTTOM'
		__entries = {u'CENTER': (eVAnchor.CENTER, None), u'TOP': (eVAnchor.TOP, None), u'BOTTOM': (eVAnchor.BOTTOM, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'CENTER': eVAnchor.CENTER, u'TOP': eVAnchor.TOP, u'BOTTOM': eVAnchor.BOTTOM}
		__module__ = 'GUI'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'Simple.eVAnchor'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class Flash(Simple):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Flash'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class FlashText(Simple):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'FlashText'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	explicitSize = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	font = property(lambda self: None)
	fontSize = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	multiline = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	def stringDimensions(self, *args, **kwargs): pass
	def stringWidth(self, *args, **kwargs): pass
	text = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	underline = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)
	wordWrap = property(lambda self: None)


class Frame2(Simple):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Frame2'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class GUIComponentColour(pybind11_object):
	def __add__(self, *args, **kwargs): pass
	def __cmp__(self, *args, **kwargs): pass
	def __copy__(self, *args, **kwargs): pass
	def __deepcopy__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __div__(self, *args, **kwargs): pass
	__doc__ = None
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __iadd__(self, *args, **kwargs): pass
	def __idiv__(self, *args, **kwargs): pass
	def __imul__(self, *args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __isub__(self, *args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	__module__ = 'GUI'
	def __mul__(self, *args, **kwargs): pass
	def __ne__(self, *args, **kwargs): pass
	def __neg__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	def __pos__(self, *args, **kwargs): pass
	__qualname__ = 'GUIComponentColour'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __rmul__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(self, *args, **kwargs): pass
	def __sub__(self, *args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __truediv__(self, *args, **kwargs): pass
	def cross2D(self, *args, **kwargs): pass
	def distSqrTo(self, *args, **kwargs): pass
	def distTo(self, *args, **kwargs): pass
	def dot(self, *args, **kwargs): pass
	def flatDistSqrTo(self, *args, **kwargs): pass
	def flatDistTo(self, *args, **kwargs): pass
	def getVector(self, *args, **kwargs): pass
	isReference = property(lambda self: None)
	length = property(lambda self: None)
	lengthSquared = property(lambda self: None)
	def list(self, *args, **kwargs): pass
	def normalise(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	def setPitchYaw(self, *args, **kwargs): pass
	def setVector(self, *args, **kwargs): pass
	def tuple(self, *args, **kwargs): pass
	w = property(lambda self: None)
	x = property(lambda self: None)
	y = property(lambda self: None)
	z = property(lambda self: None)


class GUIComponentPosition(pybind11_object):
	def __add__(self, *args, **kwargs): pass
	def __cmp__(self, *args, **kwargs): pass
	def __copy__(self, *args, **kwargs): pass
	def __deepcopy__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __div__(self, *args, **kwargs): pass
	__doc__ = None
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __iadd__(self, *args, **kwargs): pass
	def __idiv__(self, *args, **kwargs): pass
	def __imul__(self, *args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __isub__(self, *args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	__module__ = 'GUI'
	def __mul__(self, *args, **kwargs): pass
	def __ne__(self, *args, **kwargs): pass
	def __neg__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	def __pos__(self, *args, **kwargs): pass
	__qualname__ = 'GUIComponentPosition'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __rmul__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(self, *args, **kwargs): pass
	def __sub__(self, *args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __truediv__(self, *args, **kwargs): pass
	def angle(self, *args, **kwargs): pass
	def cross2D(self, *args, **kwargs): pass
	def distSqrTo(self, *args, **kwargs): pass
	def distTo(self, *args, **kwargs): pass
	def dot(self, *args, **kwargs): pass
	def flatDistSqrTo(self, *args, **kwargs): pass
	def flatDistTo(self, *args, **kwargs): pass
	def getVector(self, *args, **kwargs): pass
	isReference = property(lambda self: None)
	def isZero(self, *args, **kwargs): pass
	length = property(lambda self: None)
	lengthSquared = property(lambda self: None)
	def list(self, *args, **kwargs): pass
	def normalise(self, *args, **kwargs): pass
	pitch = property(lambda self: None)
	def scale(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	def setPitchYaw(self, *args, **kwargs): pass
	def setVector(self, *args, **kwargs): pass
	def signedAngle(self, *args, **kwargs): pass
	def tuple(self, *args, **kwargs): pass
	x = property(lambda self: None)
	y = property(lambda self: None)
	yaw = property(lambda self: None)
	z = property(lambda self: None)


class GUIComponentSize(pybind11_object):
	def __add__(self, *args, **kwargs): pass
	def __cmp__(self, *args, **kwargs): pass
	def __copy__(self, *args, **kwargs): pass
	def __deepcopy__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __div__(self, *args, **kwargs): pass
	__doc__ = None
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __iadd__(self, *args, **kwargs): pass
	def __idiv__(self, *args, **kwargs): pass
	def __imul__(self, *args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __isub__(self, *args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	__module__ = 'GUI'
	def __mul__(self, *args, **kwargs): pass
	def __ne__(self, *args, **kwargs): pass
	def __neg__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	def __pos__(self, *args, **kwargs): pass
	__qualname__ = 'GUIComponentSize'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __rmul__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(self, *args, **kwargs): pass
	def __sub__(self, *args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __truediv__(self, *args, **kwargs): pass
	def angle(self, *args, **kwargs): pass
	def cross2D(self, *args, **kwargs): pass
	def distSqrTo(self, *args, **kwargs): pass
	def distTo(self, *args, **kwargs): pass
	def dot(self, *args, **kwargs): pass
	def flatDistSqrTo(self, *args, **kwargs): pass
	def flatDistTo(self, *args, **kwargs): pass
	def getVector(self, *args, **kwargs): pass
	isReference = property(lambda self: None)
	length = property(lambda self: None)
	lengthSquared = property(lambda self: None)
	def list(self, *args, **kwargs): pass
	def normalise(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	def setPitchYaw(self, *args, **kwargs): pass
	def setVector(self, *args, **kwargs): pass
	def signedAngle(self, *args, **kwargs): pass
	def tuple(self, *args, **kwargs): pass
	x = property(lambda self: None)
	y = property(lambda self: None)


class InputCursor(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'InputCursor'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class MatrixShader(GUIShader):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MatrixShader'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	blend = property(lambda self: None)
	eta = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	target = property(lambda self: None)
	wg_targetUpdating = property(lambda self: None)


class MouseCursor(InputCursor):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MouseCursor'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	active = property(lambda self: None)
	clipped = property(lambda self: None)
	dynamic = property(lambda self: None)
	hotSpot = property(lambda self: None)
	inFocus = property(lambda self: None)
	inWindow = property(lambda self: None)
	position = property(lambda self: None)
	shape = property(lambda self: None)
	visible = property(lambda self: None)


class SimpleGUI(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SimpleGUI'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class Text(Simple):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Text'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	colourFormatting = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	explicitSize = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	font = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	multiline = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	def stringDimensions(self, *args, **kwargs): pass
	def stringWidth(self, *args, **kwargs): pass
	text = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGAbstractGunMarkerDataProvider(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGAbstractGunMarkerDataProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	positionMatrixProvider = property(lambda self: None)
	def setStartSize(self, *args, **kwargs): pass
	sizeConstraint = property(lambda self: None)
	def updateSize(self, *args, **kwargs): pass


class WGAimFlash(Flash):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGAimFlash'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	def updateMarkerPos(self, *args, **kwargs): pass
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGSPGGunMarkerDataProvider(WGAbstractGunMarkerDataProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGSPGGunMarkerDataProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	enableSmoothFiltering = property(lambda self: None)
	def getPointsInside(self, *args, **kwargs): pass
	maxTime = property(lambda self: None)
	positionMatrixProvider = property(lambda self: None)
	relaxTime = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	serverTickLength = property(lambda self: None)
	def setRelaxTime(self, *args, **kwargs): pass
	def setStartSize(self, *args, **kwargs): pass
	def setupConicDispersion(self, *args, **kwargs): pass
	def setupFlatRadialDispersion(self, *args, **kwargs): pass
	sizeConstraint = property(lambda self: None)
	sizeScaleRate = property(lambda self: None)
	def update(self, *args, **kwargs): pass
	def updateSize(self, *args, **kwargs): pass


class WGAssaultSPGGunMarkerDataProvider(WGSPGGunMarkerDataProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGAssaultSPGGunMarkerDataProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	enableSmoothFiltering = property(lambda self: None)
	def getPointsInside(self, *args, **kwargs): pass
	maxTime = property(lambda self: None)
	positionMatrixProvider = property(lambda self: None)
	relaxTime = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	serverTickLength = property(lambda self: None)
	def setRelaxTime(self, *args, **kwargs): pass
	def setStartSize(self, *args, **kwargs): pass
	def setupConicDispersion(self, *args, **kwargs): pass
	def setupFlatRadialDispersion(self, *args, **kwargs): pass
	sizeConstraint = property(lambda self: None)
	sizeScaleRate = property(lambda self: None)
	def update(self, *args, **kwargs): pass
	def updateSize(self, *args, **kwargs): pass


class WGBinoculars(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGBinoculars'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def getEnabled(self, *args, **kwargs): pass
	def resetTextures(self, *args, **kwargs): pass
	def setBackgroundTexture(self, *args, **kwargs): pass
	def setColorGradingTexture(self, *args, **kwargs): pass
	def setDistortionTexture(self, *args, **kwargs): pass
	def setEnableLensEffects(self, *args, **kwargs): pass
	def setEnabled(self, *args, **kwargs): pass
	def setMaskCenter(self, *args, **kwargs): pass
	def setParams(self, *args, **kwargs): pass


class WGCrosshairFlash(Flash):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGCrosshairFlash'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	def clearDataProvider(self, *args, **kwargs): pass
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	def setDataProvider(self, *args, **kwargs): pass
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGDirectionIndicatorFlash(Flash):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGDirectionIndicatorFlash'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	position3D = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	relativeRadius = property(lambda self: None)
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	shaders = property(lambda self: None)
	showAlways = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGGunMarkerDataProvider(WGAbstractGunMarkerDataProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGGunMarkerDataProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	positionMatrixProvider = property(lambda self: None)
	def setStartSize(self, *args, **kwargs): pass
	sizeConstraint = property(lambda self: None)
	def updateSize(self, *args, **kwargs): pass


class WGHangarVehicleMarker(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGHangarVehicleMarker'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def markerSetActive(self, *args, **kwargs): pass
	def setMarker(self, *args, **kwargs): pass


class WGHitIndicatorFlash(Flash):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGHitIndicatorFlash'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def invoke(self, *args, **kwargs): pass
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	def offsetRotationElementsInDegree(self, *args, **kwargs): pass
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	def setGlobalYaw(self, *args, **kwargs): pass
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	useInvertCameraView = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGMarkerPositionController(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGMarkerPositionController'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def add(self, *args, **kwargs): pass
	def clear(self, *args, **kwargs): pass
	def remove(self, *args, **kwargs): pass


class WGMinimapFlashAS3(Flash):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGMinimapFlashAS3'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addEntry(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delEntry(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	def entryInvoke(self, *args, **kwargs): pass
	def entrySetActive(self, *args, **kwargs): pass
	def entrySetMatrix(self, *args, **kwargs): pass
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	mapSize = property(lambda self: None)
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	def moveEntry(self, *args, **kwargs): pass
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	def setArenaBB(self, *args, **kwargs): pass
	def setBackground(self, *args, **kwargs): pass
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGPredictionIndicatorFlash(Flash):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGPredictionIndicatorFlash'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def invoke(self, *args, **kwargs): pass
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	def setGlobalYaw(self, *args, **kwargs): pass
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	useInvertCameraView = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGSPGCrosshairFlash(Flash):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGSPGCrosshairFlash'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	def clearDataProvider(self, *args, **kwargs): pass
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	def setDataProvider(self, *args, **kwargs): pass
	def setPointsBaseScale(self, *args, **kwargs): pass
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGScrollingMinimapGUIComponentAS3(WGMinimapFlashAS3):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGScrollingMinimapGUIComponentAS3'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addEntry(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	def changeMinimapZoom(self, *args, **kwargs): pass
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delEntry(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	def entryInvoke(self, *args, **kwargs): pass
	def entrySetActive(self, *args, **kwargs): pass
	def entrySetMatrix(self, *args, **kwargs): pass
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def getCenterPosition(self, *args, **kwargs): pass
	def getVisualBound(self, *args, **kwargs): pass
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	mapSize = property(lambda self: None)
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	def moveEntry(self, *args, **kwargs): pass
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	def setArenaBB(self, *args, **kwargs): pass
	def setBackground(self, *args, **kwargs): pass
	def setEntryParameters(self, *args, **kwargs): pass
	def setMiniMinimapHighlightProps(self, *args, **kwargs): pass
	def setMinimapCenterEntry(self, *args, **kwargs): pass
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGTankIndicatorFlash(Flash):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGTankIndicatorFlash'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_hullMatProv = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	wg_turretMatProv = property(lambda self: None)
	wg_turretYawConstraints = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGTrajectoryDrawer(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGTrajectoryDrawer'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def setColors(self, *args, **kwargs): pass
	def setIgnoredIDs(self, *args, **kwargs): pass
	def setParams(self, *args, **kwargs): pass
	def setStrategicMode(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	visible = property(lambda self: None)


class WGUIBackgroundBlur(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGUIBackgroundBlur'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addRect(self, *args, **kwargs): pass
	blendMask = property(lambda self: None)
	blurRadius = property(lambda self: None)
	enable = property(lambda self: None)
	fadeTime = property(lambda self: None)
	def removeAllRects(self, *args, **kwargs): pass
	def removeRect(self, *args, **kwargs): pass


class WGUIOptimizer(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGUIOptimizer'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def getEnable(self, *args, **kwargs): pass
	def registerRect(self, *args, **kwargs): pass
	def setEnable(self, *args, **kwargs): pass
	def unregisterRect(self, *args, **kwargs): pass
	def unregisterRects(self, *args, **kwargs): pass
	def updateRect(self, *args, **kwargs): pass


class WGVehicleCustomizationAnchors(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGVehicleCustomizationAnchors'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addAnchor(self, *args, **kwargs): pass
	def attachMenuToAnchor(self, *args, **kwargs): pass
	def changeAnchorParams(self, *args, **kwargs): pass
	def delAnchor(self, *args, **kwargs): pass
	def displayLine(self, *args, **kwargs): pass
	def displayMenu(self, *args, **kwargs): pass
	def registerInscriptionController(self, *args, **kwargs): pass
	def resetCollisions(self, *args, **kwargs): pass
	def setAnchorShift(self, *args, **kwargs): pass
	def setCollisions(self, *args, **kwargs): pass
	def setInterfaceScale(self, *args, **kwargs): pass
	def setMainView(self, *args, **kwargs): pass
	def setMenuParams(self, *args, **kwargs): pass
	def updateAnchorPositionAndNormal(self, *args, **kwargs): pass


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


class WGVehicleMagneticAimMarkerMatrixProvider(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGVehicleMagneticAimMarkerMatrixProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class WGVehicleMarkerMP(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGVehicleMarkerMP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	clamp = property(lambda self: None)
	clampMargin = property(lambda self: None)
	clipOffset = property(lambda self: None)
	constScale = property(lambda self: None)
	observer = property(lambda self: None)
	scaleRatio = property(lambda self: None)
	def startScaleAnimation(self, *args, **kwargs): pass
	target = property(lambda self: None)


class WGVehicleMarkersCanvasFlashAS3(Flash):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGVehicleMarkersCanvasFlashAS3'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	activeCameraAimOffset = property(lambda self: None)
	def addChild(self, *args, **kwargs): pass
	def addMarker(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delMarker(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	enableMarkerHovering = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def getAimedAtMarker(self, *args, **kwargs): pass
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	def markerInvoke(self, *args, **kwargs): pass
	def markerSetActive(self, *args, **kwargs): pass
	def markerSetBoundCheckEnabled(self, *args, **kwargs): pass
	def markerSetLocationOffset(self, *args, **kwargs): pass
	def markerSetMarkerObjectInFocus(self, *args, **kwargs): pass
	def markerSetMatrix(self, *args, **kwargs): pass
	def markerSetMinScale(self, *args, **kwargs): pass
	def markerSetRenderInfo(self, *args, **kwargs): pass
	def markerSetSticky(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	scaleProperties = property(lambda self: None)
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	stickyMarkerRadiusScale = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	def updateCameraAimOffset(self, *args, **kwargs): pass
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WGVehicleMarkersMatrixProvider(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGVehicleMarkersMatrixProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class Window(Simple):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Window'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	maxScroll = property(lambda self: None)
	minScroll = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	scroll = property(lambda self: None)
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)


class WorldToClipMP(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WorldToClipMP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	onlyFront = property(lambda self: None)
	target = property(lambda self: None)


class WulfFlashComponent(Flash):
	ADD = eMaterialFX.ADD
	ADD_SIGNED = eMaterialFX.ADD_SIGNED
	ALPHA_TEST = eMaterialFX.ALPHA_TEST
	BLEND = eMaterialFX.BLEND
	BLEND2X = eMaterialFX.BLEND2X
	BLEND_COLOUR = eMaterialFX.BLEND_COLOUR
	BLEND_INVERSE_ALPHA = eMaterialFX.BLEND_INVERSE_ALPHA
	BLEND_INVERSE_COLOUR = eMaterialFX.BLEND_INVERSE_COLOUR
	BOTTOM = eVAnchor.BOTTOM
	CENTER = eVAnchor.CENTER
	CLIP = eSizeMode.CLIP
	LEFT = eHAnchor.LEFT
	LEGACY = eSizeMode.LEGACY
	LINEAR = eFilterType.LINEAR
	MODULATE2X = eMaterialFX.MODULATE2X
	NONE = eFilterType.NONE
	PIXEL = eSizeMode.PIXEL
	POINT = eFilterType.POINT
	RIGHT = eHAnchor.RIGHT
	SOLID = eMaterialFX.SOLID
	TOP = eVAnchor.TOP
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'GUI'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WulfFlashComponent'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addChild(self, *args, **kwargs): pass
	def addShader(self, *args, **kwargs): pass
	angle = property(lambda self: None)
	children = property(lambda self: None)
	colour = property(lambda self: None)
	crossFocus = property(lambda self: None)
	def delChild(self, *args, **kwargs): pass
	def delShader(self, *args, **kwargs): pass
	dragFocus = property(lambda self: None)
	drawWithRestrictedViewPort = property(lambda self: None)
	dropFocus = property(lambda self: None)
	filterType = property(lambda self: None)
	flip = property(lambda self: None)
	focus = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasChild(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightMode = property(lambda self: None)
	heightRelative = property(lambda self: None)
	def hitTest(self, *args, **kwargs): pass
	horizontalAnchor = property(lambda self: None)
	horizontalPositionMode = property(lambda self: None)
	def localToScreen(self, *args, **kwargs): pass
	materialFX = property(lambda self: None)
	mouseButtonFocus = property(lambda self: None)
	moveFocus = property(lambda self: None)
	movie = property(lambda self: None)
	moviePath = property(lambda self: None)
	parent = property(lambda self: None)
	pixelSnap = property(lambda self: None)
	position = property(lambda self: None)
	def reSort(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def screenToLocal(self, *args, **kwargs): pass
	script = property(lambda self: None)
	shaders = property(lambda self: None)
	size = property(lambda self: None)
	textureName = property(lambda self: None)
	tileHeight = property(lambda self: None)
	tileWidth = property(lambda self: None)
	tiled = property(lambda self: None)
	verticalAnchor = property(lambda self: None)
	verticalPositionMode = property(lambda self: None)
	visible = property(lambda self: None)
	visibleInAppFocusOnly = property(lambda self: None)
	wg_inputKeyMode = property(lambda self: None)
	width = property(lambda self: None)
	widthMode = property(lambda self: None)
	widthRelative = property(lambda self: None)

__doc__ = None
__name__ = 'GUI'
__package__ = None
def addRoot(*args, **kwargs): pass
def delRoot(*args, **kwargs): pass
def enableMarkerDebugDraw(*args, **kwargs): pass
def handleAxisEvent(*args, **kwargs): pass
def handleKeyEvent(*args, **kwargs): pass
def handleMouseEvent(*args, **kwargs): pass
def load(*args, **kwargs): pass
def mcursor(*args, **kwargs): pass
def printRoots(*args, **kwargs): pass
def reSort(*args, **kwargs): pass
def roots(*args, **kwargs): pass
def screenResolution(*args, **kwargs): pass
def setDragDistance(*args, **kwargs): pass
def setResolutionOverride(*args, **kwargs): pass
def syncMousePosition(*args, **kwargs): pass
def wg_setGlyphCacheParams(*args, **kwargs): pass