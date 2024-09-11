# Stubs Generator
# import Math
# <module 'Math' (built-in)>


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


class IFilter(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'IFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class FIRFilter(IFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'FIRFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def add(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass
	value = property(lambda self: None)


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


class Matrix(MatrixProvider):
	def __call__(self, *args, **kwargs): pass
	def __copy__(self, *args, **kwargs): pass
	def __deepcopy__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Matrix'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(self, *args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def applyPoint(self, *args, **kwargs): pass
	def applyToAxis(self, *args, **kwargs): pass
	def applyToOrigin(self, *args, **kwargs): pass
	def applyV4Point(self, *args, **kwargs): pass
	def applyVector(self, *args, **kwargs): pass
	determinant = property(lambda self: None)
	def get(self, *args, **kwargs): pass
	def getElement(self, *args, **kwargs): pass
	def invert(self, *args, **kwargs): pass
	isMirrored = property(lambda self: None)
	def lookAt(self, *args, **kwargs): pass
	def orthogonalProjection(self, *args, **kwargs): pass
	def perspectiveProjection(self, *args, **kwargs): pass
	pitch = property(lambda self: None)
	def postMultiply(self, *args, **kwargs): pass
	def preMultiply(self, *args, **kwargs): pass
	roll = property(lambda self: None)
	scale = property(lambda self: None)
	def set(self, *args, **kwargs): pass
	def setElement(self, *args, **kwargs): pass
	def setIdentity(self, *args, **kwargs): pass
	def setRotateX(self, *args, **kwargs): pass
	def setRotateY(self, *args, **kwargs): pass
	def setRotateYPR(self, *args, **kwargs): pass
	def setRotateZ(self, *args, **kwargs): pass
	def setScale(self, *args, **kwargs): pass
	def setTranslate(self, *args, **kwargs): pass
	def setZero(self, *args, **kwargs): pass
	translation = property(lambda self: None)
	yaw = property(lambda self: None)


class MatrixAnimation(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MatrixAnimation'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	keyframes = property(lambda self: None)
	loop = property(lambda self: None)
	time = property(lambda self: None)


class MatrixInverse(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MatrixInverse'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)


class MatrixKeyframeVector(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __iter__(self, *args, **kwargs): pass
	def __len__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MatrixKeyframeVector'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def back(self, *args, **kwargs): pass
	def pop_back(self, *args, **kwargs): pass
	def push_back(self, *args, **kwargs): pass


class MatrixProduct(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MatrixProduct'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	a = property(lambda self: None)
	b = property(lambda self: None)


class OBB(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'OBB'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	matrix = property(lambda self: None)


class Plane(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Plane'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def init(self, *args, **kwargs): pass
	def intersectRay(self, *args, **kwargs): pass


class PyOscillator(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyOscillator'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def applyImpulse(self, *args, **kwargs): pass
	constraints = property(lambda self: None)
	deviation = property(lambda self: None)
	externalForce = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	velocity = property(lambda self: None)


class PyCompoundOscillator(PyOscillator):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyCompoundOscillator'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def applyImpulse(self, *args, **kwargs): pass
	constraints = property(lambda self: None)
	deviation = property(lambda self: None)
	externalForce = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	velocity = property(lambda self: None)


class PyNoiseOscillator(PyOscillator):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyNoiseOscillator'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def applyImpulse(self, *args, **kwargs): pass
	constraints = property(lambda self: None)
	deviation = property(lambda self: None)
	externalForce = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	velocity = property(lambda self: None)


class PyRandomNoiseOscillatorFlat(PyOscillator):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyRandomNoiseOscillatorFlat'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def applyImpulse(self, *args, **kwargs): pass
	constraints = property(lambda self: None)
	deviation = property(lambda self: None)
	externalForce = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	velocity = property(lambda self: None)


class PyRandomNoiseOscillatorSpherical(PyOscillator):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyRandomNoiseOscillatorSpherical'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def applyImpulse(self, *args, **kwargs): pass
	constraints = property(lambda self: None)
	deviation = property(lambda self: None)
	externalForce = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	velocity = property(lambda self: None)


class RangeFilter(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'RangeFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def add(self, *args, **kwargs): pass
	maxLength = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	value = property(lambda self: None)


class SMAFilter(FIRFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SMAFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def add(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass
	value = property(lambda self: None)


class Vector2(pybind11_object):
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
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __iadd__(self, *args, **kwargs): pass
	def __idiv__(self, *args, **kwargs): pass
	def __imul__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __isub__(self, *args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	__module__ = 'Math'
	def __mul__(self, *args, **kwargs): pass
	def __ne__(self, *args, **kwargs): pass
	def __neg__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	def __pos__(self, *args, **kwargs): pass
	__qualname__ = 'Vector2'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __rmul__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(self, *args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
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


class Vector3(pybind11_object):
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
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __iadd__(self, *args, **kwargs): pass
	def __idiv__(self, *args, **kwargs): pass
	def __imul__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __isub__(self, *args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	__module__ = 'Math'
	def __mul__(self, *args, **kwargs): pass
	def __ne__(self, *args, **kwargs): pass
	def __neg__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	def __pos__(self, *args, **kwargs): pass
	__qualname__ = 'Vector3'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __rmul__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(self, *args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
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


class Vector4(pybind11_object):
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
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __iadd__(self, *args, **kwargs): pass
	def __idiv__(self, *args, **kwargs): pass
	def __imul__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __isub__(self, *args, **kwargs): pass
	def __len__(*args, **kwargs): pass
	__module__ = 'Math'
	def __mul__(self, *args, **kwargs): pass
	def __ne__(self, *args, **kwargs): pass
	def __neg__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	def __pos__(self, *args, **kwargs): pass
	__qualname__ = 'Vector4'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __rmul__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(self, *args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
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


class Vector4Provider(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4Provider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	value = property(lambda self: None)


class Vector4Animation(Vector4Provider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4Animation'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	duration = property(lambda self: None)
	keyframes = property(lambda self: None)
	time = property(lambda self: None)
	value = property(lambda self: None)


class Vector4Basic(Vector4Provider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4Basic'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	value = property(lambda self: None)


class Vector4Combiner(Vector4Provider):
	ADD = Fn.ADD
	DIVIDE = Fn.DIVIDE
	DOT = Fn.DOT
	
	class Fn(pybind11_object):
		ADD = Fn.ADD
		DIVIDE = Fn.DIVIDE
		DOT = Fn.DOT
		MAX = Fn.MAX
		MIN = Fn.MIN
		MULTIPLY = Fn.MULTIPLY
		SUBTRACT = Fn.SUBTRACT
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  ADD\n\n  DIVIDE\n\n  MIN\n\n  MULTIPLY\n\n  MAX\n\n  SUBTRACT\n\n  DOT'
		__entries = {u'ADD': (Fn.ADD, None), u'DIVIDE': (Fn.DIVIDE, None), u'MIN': (Fn.MIN, None), u'MULTIPLY': (Fn.MULTIPLY, None), u'MAX': (Fn.MAX, None), u'SUBTRACT': (Fn.SUBTRACT, None), u'DOT': (Fn.DOT, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'ADD': Fn.ADD, u'DIVIDE': Fn.DIVIDE, u'MIN': Fn.MIN, u'MULTIPLY': Fn.MULTIPLY, u'MAX': Fn.MAX, u'SUBTRACT': Fn.SUBTRACT, u'DOT': Fn.DOT}
		__module__ = 'Math'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'Vector4Combiner.Fn'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	MAX = Fn.MAX
	MIN = Fn.MIN
	MULTIPLY = Fn.MULTIPLY
	SUBTRACT = Fn.SUBTRACT
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4Combiner'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	a = property(lambda self: None)
	b = property(lambda self: None)
	fn = property(lambda self: None)
	value = property(lambda self: None)


class Vector4Distance(Vector4Provider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4Distance'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	a = property(lambda self: None)
	b = property(lambda self: None)
	value = property(lambda self: None)


class Vector4LFO(Vector4Provider):
	SAWTOOTH = Waveform.SAWTOOTH
	SINE = Waveform.SINE
	SQUARE = Waveform.SQUARE
	TRIANGLE = Waveform.TRIANGLE
	
	class Waveform(pybind11_object):
		SAWTOOTH = Waveform.SAWTOOTH
		SINE = Waveform.SINE
		SQUARE = Waveform.SQUARE
		TRIANGLE = Waveform.TRIANGLE
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  SINE\n\n  TRIANGLE\n\n  SQUARE\n\n  SAWTOOTH'
		__entries = {u'SINE': (Waveform.SINE, None), u'TRIANGLE': (Waveform.TRIANGLE, None), u'SQUARE': (Waveform.SQUARE, None), u'SAWTOOTH': (Waveform.SAWTOOTH, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'SINE': Waveform.SINE, u'SQUARE': Waveform.SQUARE, u'TRIANGLE': Waveform.TRIANGLE, u'SAWTOOTH': Waveform.SAWTOOTH}
		__module__ = 'Math'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'Vector4LFO.Waveform'
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
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4LFO'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	amplitude = property(lambda self: None)
	period = property(lambda self: None)
	phase = property(lambda self: None)
	time = property(lambda self: None)
	value = property(lambda self: None)
	waveform = property(lambda self: None)


class Vector4MatrixAdaptor(MatrixProvider):
	STYLE_LOOKAT = Style.STYLE_LOOKAT
	STYLE_LOOKAT_SCALEZ = Style.STYLE_LOOKAT_SCALEZ
	STYLE_XYZ_SCALE = Style.STYLE_XYZ_SCALE
	STYLE_XY_SCALE = Style.STYLE_XY_SCALE
	STYLE_X_ROTATE = Style.STYLE_X_ROTATE
	STYLE_Y_ROTATE = Style.STYLE_Y_ROTATE
	STYLE_Z_ROTATE = Style.STYLE_Z_ROTATE
	
	class Style(pybind11_object):
		STYLE_LOOKAT = Style.STYLE_LOOKAT
		STYLE_LOOKAT_SCALEZ = Style.STYLE_LOOKAT_SCALEZ
		STYLE_XYZ_SCALE = Style.STYLE_XYZ_SCALE
		STYLE_XY_SCALE = Style.STYLE_XY_SCALE
		STYLE_X_ROTATE = Style.STYLE_X_ROTATE
		STYLE_Y_ROTATE = Style.STYLE_Y_ROTATE
		STYLE_Z_ROTATE = Style.STYLE_Z_ROTATE
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  STYLE_Y_ROTATE\n\n  STYLE_X_ROTATE\n\n  STYLE_LOOKAT\n\n  STYLE_LOOKAT_SCALEZ\n\n  STYLE_Z_ROTATE\n\n  STYLE_XY_SCALE\n\n  STYLE_XYZ_SCALE'
		__entries = {u'STYLE_Y_ROTATE': (Style.STYLE_Y_ROTATE, None), u'STYLE_X_ROTATE': (Style.STYLE_X_ROTATE, None), u'STYLE_LOOKAT': (Style.STYLE_LOOKAT, None), u'STYLE_LOOKAT_SCALEZ': (Style.STYLE_LOOKAT_SCALEZ, None), u'STYLE_Z_ROTATE': (Style.STYLE_Z_ROTATE, None), u'STYLE_XY_SCALE': (Style.STYLE_XY_SCALE, None), u'STYLE_XYZ_SCALE': (Style.STYLE_XYZ_SCALE, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'STYLE_Y_ROTATE': Style.STYLE_Y_ROTATE, u'STYLE_X_ROTATE': Style.STYLE_X_ROTATE, u'STYLE_Z_ROTATE': Style.STYLE_Z_ROTATE, u'STYLE_LOOKAT_SCALEZ': Style.STYLE_LOOKAT_SCALEZ, u'STYLE_LOOKAT': Style.STYLE_LOOKAT, u'STYLE_XY_SCALE': Style.STYLE_XY_SCALE, u'STYLE_XYZ_SCALE': Style.STYLE_XYZ_SCALE}
		__module__ = 'Math'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'Vector4MatrixAdaptor.Style'
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
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4MatrixAdaptor'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	position = property(lambda self: None)
	source = property(lambda self: None)
	style = property(lambda self: None)


class Vector4Morph(Vector4Provider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4Morph'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	duration = property(lambda self: None)
	target = property(lambda self: None)
	time = property(lambda self: None)
	value = property(lambda self: None)


class Vector4Product(Vector4Provider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4Product'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	a = property(lambda self: None)
	b = property(lambda self: None)
	value = property(lambda self: None)


class Vector4Shader(Vector4Provider):
	OP_ADD = Op.OP_ADD
	OP_BIAS = Op.OP_BIAS
	OP_COMPLEMENT = Op.OP_COMPLEMENT
	OP_DIVIDE = Op.OP_DIVIDE
	OP_DOT = Op.OP_DOT
	OP_MAX = Op.OP_MAX
	OP_MIN = Op.OP_MIN
	OP_MOVE = Op.OP_MOVE
	OP_MULTIPLY = Op.OP_MULTIPLY
	OP_RECIPROCAL = Op.OP_RECIPROCAL
	OP_SGE = Op.OP_SGE
	OP_SLT = Op.OP_SLT
	OP_SUBTRACT = Op.OP_SUBTRACT
	
	class Op(pybind11_object):
		OP_ADD = Op.OP_ADD
		OP_BIAS = Op.OP_BIAS
		OP_COMPLEMENT = Op.OP_COMPLEMENT
		OP_DIVIDE = Op.OP_DIVIDE
		OP_DOT = Op.OP_DOT
		OP_MAX = Op.OP_MAX
		OP_MIN = Op.OP_MIN
		OP_MOVE = Op.OP_MOVE
		OP_MULTIPLY = Op.OP_MULTIPLY
		OP_RECIPROCAL = Op.OP_RECIPROCAL
		OP_SGE = Op.OP_SGE
		OP_SLT = Op.OP_SLT
		OP_SUBTRACT = Op.OP_SUBTRACT
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  OP_DIVIDE\n\n  OP_MULTIPLY\n\n  OP_MAX\n\n  OP_BIAS\n\n  OP_RECIPROCAL\n\n  OP_MIN\n\n  OP_ADD\n\n  OP_MOVE\n\n  OP_SGE\n\n  OP_DOT\n\n  OP_COMPLEMENT\n\n  OP_SUBTRACT\n\n  OP_SLT'
		__entries = {u'OP_DIVIDE': (Op.OP_DIVIDE, None), u'OP_MULTIPLY': (Op.OP_MULTIPLY, None), u'OP_MAX': (Op.OP_MAX, None), u'OP_BIAS': (Op.OP_BIAS, None), u'OP_RECIPROCAL': (Op.OP_RECIPROCAL, None), u'OP_MIN': (Op.OP_MIN, None), u'OP_ADD': (Op.OP_ADD, None), u'OP_MOVE': (Op.OP_MOVE, None), u'OP_SGE': (Op.OP_SGE, None), u'OP_DOT': (Op.OP_DOT, None), u'OP_COMPLEMENT': (Op.OP_COMPLEMENT, None), u'OP_SUBTRACT': (Op.OP_SUBTRACT, None), u'OP_SLT': (Op.OP_SLT, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'OP_DIVIDE': Op.OP_DIVIDE, u'OP_MULTIPLY': Op.OP_MULTIPLY, u'OP_MAX': Op.OP_MAX, u'OP_BIAS': Op.OP_BIAS, u'OP_RECIPROCAL': Op.OP_RECIPROCAL, u'OP_MIN': Op.OP_MIN, u'OP_ADD': Op.OP_ADD, u'OP_MOVE': Op.OP_MOVE, u'OP_SGE': Op.OP_SGE, u'OP_DOT': Op.OP_DOT, u'OP_COMPLEMENT': Op.OP_COMPLEMENT, u'OP_SUBTRACT': Op.OP_SUBTRACT, u'OP_SLT': Op.OP_SLT}
		__module__ = 'Math'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'Vector4Shader.Op'
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
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4Shader'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addOp(self, *args, **kwargs): pass
	def getRegister(*args, **kwargs): pass
	value = property(lambda self: None)


class Vector4Swizzle(Vector4Provider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4Swizzle'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	value = property(lambda self: None)
	w = property(lambda self: None)
	x = property(lambda self: None)
	y = property(lambda self: None)
	z = property(lambda self: None)


class Vector4Translation(Vector4Provider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Vector4Translation'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)
	value = property(lambda self: None)


class VectorKeyframe(pybind11_object):
	def __contains__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __delitem__(self, *args, **kwargs): pass
	__doc__ = None
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __iter__(self, *args, **kwargs): pass
	def __len__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	
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
	
	__pybind11_module_local_v5_msvc__ = PyCapsule()
	__qualname__ = 'VectorKeyframe'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def append(self, *args, **kwargs): pass
	def clear(self, *args, **kwargs): pass
	def count(self, *args, **kwargs): pass
	def extend(self, *args, **kwargs): pass
	def insert(self, *args, **kwargs): pass
	def pop(self, *args, **kwargs): pass
	def remove(self, *args, **kwargs): pass


class WGAdaptiveMatrixProvider(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGAdaptiveMatrixProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def setStaticTransform(self, *args, **kwargs): pass
	target = property(lambda self: None)


class WGBoundMatrixProvider(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGBoundMatrixProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	maxBound = property(lambda self: None)
	minBound = property(lambda self: None)
	source = property(lambda self: None)


class WGClampMP(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGClampMP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	max = property(lambda self: None)
	min = property(lambda self: None)
	source = property(lambda self: None)


class WGCombinedMP(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGCombinedMP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	rotationSrc = property(lambda self: None)
	translationSrc = property(lambda self: None)


class WGInverseTransform(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGInverseTransform'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)


class WGRelatedToTargetMP(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGRelatedToTargetMP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)
	target = property(lambda self: None)


class WGSmoothTranslationOnlyMP(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGSmoothTranslationOnlyMP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)


class WGReplayAwaredSmoothTranslationOnlyMP(WGSmoothTranslationOnlyMP):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGReplayAwaredSmoothTranslationOnlyMP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)


class WGStrategicAreaViewMP(MatrixProvider):
	def (self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGStrategicAreaViewMP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	baseScale = property(lambda self: None)
	source = property(lambda self: None)


class WGTerrainMP(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGTerrainMP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	offset = property(lambda self: None)
	source = property(lambda self: None)


class WGTranslationOnlyMP(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGTranslationOnlyMP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)


class WGYawOnlyTransform(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Math'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGYawOnlyTransform'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)

__doc__ = None
__name__ = 'Math'
__package__ = None
def calcHullAngle(*args, **kwargs): pass
def clampVector2Length(*args, **kwargs): pass
def clampVector3(*args, **kwargs): pass
def clampVector3Length(*args, **kwargs): pass
def clampVector4Length(*args, **kwargs): pass
def createIdentityMatrix(*args, **kwargs): pass
def createRTMatrix(*args, **kwargs): pass
def createRotationMatrix(*args, **kwargs): pass
def createSRTMatrix(*args, **kwargs): pass
def createTranslationMatrix(*args, **kwargs): pass
def createVectorRotationMatrix(*args, **kwargs): pass
def getZoneIdFromPosition(*args, **kwargs): pass
def matrixScale(*args, **kwargs): pass
def slerp(*args, **kwargs): pass