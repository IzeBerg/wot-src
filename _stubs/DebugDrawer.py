# Stubs Generator
# import DebugDrawer
# <module 'DebugDrawer' (built-in)>


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


class AxesBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'AxesBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Axes(AxesBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Axes'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def centerColour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def size(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def xColour(self, *args, **kwargs): pass
	def xEndColour(self, *args, **kwargs): pass
	def xStartColour(self, *args, **kwargs): pass
	def yColour(self, *args, **kwargs): pass
	def yEndColour(self, *args, **kwargs): pass
	def yStartColour(self, *args, **kwargs): pass
	def zColour(self, *args, **kwargs): pass
	def zEndColour(self, *args, **kwargs): pass
	def zStartColour(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass

BM_ADDITIVE = BlendMode.BM_ADDITIVE
BM_ADDITIVE_NO_SCALING = BlendMode.BM_ADDITIVE_NO_SCALING
BM_OPAQUE = BlendMode.BM_OPAQUE
BM_STANDARD = BlendMode.BM_STANDARD
BM_SUBTRACTIVE = BlendMode.BM_SUBTRACTIVE
BM_SUBTRACTIVE_REVERSED_NO_SCALING = BlendMode.BM_SUBTRACTIVE_REVERSED_NO_SCALING
BM_TRANSPARENT = BlendMode.BM_TRANSPARENT

class BlendMode(pybind11_object):
	BM_ADDITIVE = BlendMode.BM_ADDITIVE
	BM_ADDITIVE_NO_SCALING = BlendMode.BM_ADDITIVE_NO_SCALING
	BM_OPAQUE = BlendMode.BM_OPAQUE
	BM_STANDARD = BlendMode.BM_STANDARD
	BM_SUBTRACTIVE = BlendMode.BM_SUBTRACTIVE
	BM_SUBTRACTIVE_REVERSED_NO_SCALING = BlendMode.BM_SUBTRACTIVE_REVERSED_NO_SCALING
	BM_TRANSPARENT = BlendMode.BM_TRANSPARENT
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  BM_SUBTRACTIVE\n\n  BM_OPAQUE\n\n  BM_ADDITIVE_NO_SCALING\n\n  BM_TRANSPARENT\n\n  BM_STANDARD\n\n  BM_ADDITIVE\n\n  BM_SUBTRACTIVE_REVERSED_NO_SCALING'
	__entries = {u'BM_SUBTRACTIVE': (BlendMode.BM_SUBTRACTIVE, None), u'BM_OPAQUE': (BlendMode.BM_OPAQUE, None), u'BM_ADDITIVE_NO_SCALING': (BlendMode.BM_ADDITIVE_NO_SCALING, None), u'BM_TRANSPARENT': (BlendMode.BM_TRANSPARENT, None), u'BM_STANDARD': (BlendMode.BM_STANDARD, None), u'BM_ADDITIVE': (BlendMode.BM_ADDITIVE, None), u'BM_SUBTRACTIVE_REVERSED_NO_SCALING': (BlendMode.BM_SUBTRACTIVE_REVERSED_NO_SCALING, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'BM_STANDARD': BlendMode.BM_STANDARD, u'BM_ADDITIVE_NO_SCALING': BlendMode.BM_ADDITIVE_NO_SCALING, u'BM_SUBTRACTIVE': BlendMode.BM_SUBTRACTIVE, u'BM_TRANSPARENT': BlendMode.BM_TRANSPARENT, u'BM_OPAQUE': BlendMode.BM_OPAQUE, u'BM_ADDITIVE': BlendMode.BM_ADDITIVE, u'BM_SUBTRACTIVE_REVERSED_NO_SCALING': BlendMode.BM_SUBTRACTIVE_REVERSED_NO_SCALING}
	__module__ = 'DebugDrawer'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'BlendMode'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


class BulletBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'BulletBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Bullet(BulletBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Bullet'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def point(self, *args, **kwargs): pass
	def pointColoured(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def width(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class ConeBuilderBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ConeBuilderBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class ConeTransformableBuilder(ConeBuilderBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ConeTransformableBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Cone(ConeTransformableBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Cone'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def height(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def radius(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class CubeBuilderBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CubeBuilderBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class CubeTransformableBuilder(CubeBuilderBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CubeTransformableBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Cube(CubeTransformableBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Cube'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class CylinderBuilderBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CylinderBuilderBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class CylinderTransformableBuilder(CylinderBuilderBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CylinderTransformableBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Cylinder(CylinderTransformableBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Cylinder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def endPoints(self, *args, **kwargs): pass
	def height(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def radius(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class DebugDrawer(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DebugDrawer'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def axes(self, *args, **kwargs): pass
	def bullet(self, *args, **kwargs): pass
	def cone(self, *args, **kwargs): pass
	def cube(self, *args, **kwargs): pass
	def cylinder(self, *args, **kwargs): pass
	def frustum(self, *args, **kwargs): pass
	def label(self, *args, **kwargs): pass
	def line(self, *args, **kwargs): pass
	def rect2D(self, *args, **kwargs): pass
	def rgbCube(self, *args, **kwargs): pass
	def sector(self, *args, **kwargs): pass
	def sphere(self, *args, **kwargs): pass
	def star(self, *args, **kwargs): pass
	def visual(self, *args, **kwargs): pass


class FrustumBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'FrustumBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Frustum(FrustumBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Frustum'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def frustum(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def width(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class LabelBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'LabelBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Label(LabelBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Label'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def font(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def text(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class LineBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'LineBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Line(LineBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Line'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def animationSpeed(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def dashDistance(self, *args, **kwargs): pass
	def dotDistance(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def lineStripTopology(self, *args, **kwargs): pass
	def point(self, *args, **kwargs): pass
	def point2D(self, *args, **kwargs): pass
	def point2DColoured(self, *args, **kwargs): pass
	def pointColoured(self, *args, **kwargs): pass
	def points(self, *args, **kwargs): pass
	def points2D(self, *args, **kwargs): pass
	def points2DColoured(self, *args, **kwargs): pass
	def pointsColoured(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def width(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class RGBCubeBuilderBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'RGBCubeBuilderBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class RGBCubeTransformableBuilder(RGBCubeBuilderBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'RGBCubeTransformableBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class RGBCube(RGBCubeTransformableBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'RGBCube'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Rect2DBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Rect2DBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Rect2D(Rect2DBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Rect2D'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def depth(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def p1(self, *args, **kwargs): pass
	def p2(self, *args, **kwargs): pass
	def solidColour(self, *args, **kwargs): pass
	def strokeColour(self, *args, **kwargs): pass
	def strokeWidth(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class SectorBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SectorBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Sector(SectorBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Sector'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def angles(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def radius(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class SphereBuilderBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SphereBuilderBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class SphereTransformableBuilder(SphereBuilderBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SphereTransformableBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Sphere(SphereTransformableBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Sphere'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def radius(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class StarBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'StarBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class Star(StarBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Star'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def centerColour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def edgeColour(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def radius(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class VisualBuilderBuilderBuilder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'VisualBuilderBuilderBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class VisualBuilderTransformableBuilder(VisualBuilderBuilderBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'VisualBuilderTransformableBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass


class VisualBuilder(VisualBuilderTransformableBuilder):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'DebugDrawer'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'VisualBuilder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def aabb(self, *args, **kwargs): pass
	def blendMode(self, *args, **kwargs): pass
	def colour(self, *args, **kwargs): pass
	def doubleSided(self, *args, **kwargs): pass
	def obb(self, *args, **kwargs): pass
	def position(self, *args, **kwargs): pass
	def rotation(self, *args, **kwargs): pass
	def scale(self, *args, **kwargs): pass
	def texture(self, *args, **kwargs): pass
	def transform(self, *args, **kwargs): pass
	def visual(self, *args, **kwargs): pass
	def wireframe(self, *args, **kwargs): pass
	def zTest(self, *args, **kwargs): pass
	def zWrite(self, *args, **kwargs): pass

__doc__ = None
__name__ = 'DebugDrawer'
__package__ = None
def drawCube(*args, **kwargs): pass
def drawCylinder(*args, **kwargs): pass
def drawSphere(*args, **kwargs): pass