# Stubs Generator
# import BigWorld
# <module 'BigWorld' (built-in)>


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


class PyMaterialHandler(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyMaterialHandler'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class (PyMaterialHandler):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = ''
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def setRepaintParams(self, *args, **kwargs): pass

A16B16G16R16 = ResourceFormat.A16B16G16R16
A16B16G16R16F = ResourceFormat.A16B16G16R16F
A1R5G5B5 = ResourceFormat.A1R5G5B5
A2B10G10R10 = ResourceFormat.A2B10G10R10
A32B32G32R32F = ResourceFormat.A32B32G32R32F
A8 = ResourceFormat.A8
A8B8G8R8 = ResourceFormat.A8B8G8R8
A8L8 = ResourceFormat.A8L8
A8R8G8B8 = ResourceFormat.A8R8G8B8
ALREADY_ONLINE_LOCALLY = LOGIN_STATUS.ALREADY_ONLINE_LOCALLY
ANGLE_RADIANS = FilterInterpolationType.ANGLE_RADIANS

class AoIEntities (pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__ (self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __iter__ (self, *args, **kwargs): pass
	def __len__ (self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	def __next__ (self, *args, **kwargs): pass
	__qualname__ = 'AoIEntities '
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __repr__ (self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def has_key (self, *args, **kwargs): pass
	def items (self, *args, **kwargs): pass
	def keys (self, *args, **kwargs): pass
	def values (self, *args, **kwargs): pass


class IAimingSystem(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'IAimingSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass


class ArcadeAimingSystem(IAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ArcadeAimingSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addVolumeGroup(self, *args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	def cursorShouldCheckCollisions(self, *args, **kwargs): pass
	def destroy(self, *args, **kwargs): pass
	def disable(self, *args, **kwargs): pass
	distanceFromFocus = property(lambda self: None)
	def enable(self, *args, **kwargs): pass
	def focusOnPos(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getPivotSettings(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getThirdPersonShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	idealMatrix = property(lambda self: None)
	def initAdvancedCollider(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	pitch = property(lambda self: None)
	positionAboveVehicleProv = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def setAnglesRange(self, *args, **kwargs): pass
	def setDynamicCollisions(self, *args, **kwargs): pass
	def setMinDistanceForShotPointCalc(self, *args, **kwargs): pass
	def setPivotSettings(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	vehicleMProv = property(lambda self: None)
	yaw = property(lambda self: None)


class ArcadeAimingSystemRemote(ArcadeAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ArcadeAimingSystemRemote'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addVolumeGroup(self, *args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	def cursorShouldCheckCollisions(self, *args, **kwargs): pass
	def destroy(self, *args, **kwargs): pass
	def disable(self, *args, **kwargs): pass
	distanceFromFocus = property(lambda self: None)
	def enable(self, *args, **kwargs): pass
	def focusOnPos(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getPivotSettings(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getThirdPersonShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	idealMatrix = property(lambda self: None)
	def initAdvancedCollider(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	pitch = property(lambda self: None)
	positionAboveVehicleProv = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def setAnglesRange(self, *args, **kwargs): pass
	def setDynamicCollisions(self, *args, **kwargs): pass
	def setMinDistanceForShotPointCalc(self, *args, **kwargs): pass
	def setPivotSettings(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	vehicleMProv = property(lambda self: None)
	yaw = property(lambda self: None)


class ArenaBorderHelper(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ArenaBorderHelper'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def removeBorder(*args, **kwargs): pass
	def setArenaBorderBounds(*args, **kwargs): pass
	def setArenaBorderColor(*args, **kwargs): pass
	def setArenaBorderDistanceFadeMode(*args, **kwargs): pass
	def setArenaBorderDrawType(*args, **kwargs): pass
	def setArenaBorderVisible(*args, **kwargs): pass
	def setBorderBounds(*args, **kwargs): pass
	def setBorderColor(*args, **kwargs): pass
	def setBorderHeight(*args, **kwargs): pass
	def setBorderMask(*args, **kwargs): pass
	def setBorderMaxAlpha(*args, **kwargs): pass
	def setBorderVisible(*args, **kwargs): pass
	def setBordersDistanceFadeEnabled(*args, **kwargs): pass
	def setBordersDrawType(*args, **kwargs): pass
	def setOutsideShift(*args, **kwargs): pass
	def updatePolygonBordersColor(*args, **kwargs): pass


class BaseStrategicAimingSystem(IAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'BaseStrategicAimingSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def getCamDist(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightFromPlane = property(lambda self: None)
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def overrideCamDist(self, *args, **kwargs): pass
	planePosition = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def setYaw(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	def updateTargetPos(self, *args, **kwargs): pass


class ArtyAimingSystem(BaseStrategicAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ArtyAimingSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	aimPoint = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	direction = property(lambda self: None)
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def getCamDist(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightFromPlane = property(lambda self: None)
	hitPoint = property(lambda self: None)
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def overrideCamDist(self, *args, **kwargs): pass
	planePosition = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def setYaw(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	def updateTargetPos(self, *args, **kwargs): pass


class ArtyAimingSystemRemote(ArtyAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ArtyAimingSystemRemote'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	aimPoint = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	direction = property(lambda self: None)
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def getCamDist(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightFromPlane = property(lambda self: None)
	hitPoint = property(lambda self: None)
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def overrideCamDist(self, *args, **kwargs): pass
	planePosition = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def setYaw(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	def updateTargetPos(self, *args, **kwargs): pass


class AssaultAimingSystem(IAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'AssaultAimingSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	aimPoint = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	direction = property(lambda self: None)
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getSphereCollisionDist(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	position = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def setCollisionSphereRadius(self, *args, **kwargs): pass
	def setDistInterpolationSpeedParams(self, *args, **kwargs): pass
	def setPitchInterpolationSpeed(self, *args, **kwargs): pass
	def setState(self, *args, **kwargs): pass
	def setup(self, *args, **kwargs): pass
	transitionBlocked = property(lambda self: None)
	def update(self, *args, **kwargs): pass


class Attachments(pybind11_object):
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
	__module__ = 'BigWorld'
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
	__qualname__ = 'Attachments'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
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


class AutoAim(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'AutoAim'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	adhesionDistance = property(lambda self: None)
	adhesionFalloffDistance = property(lambda self: None)
	adhesionHorizontalAngle = property(lambda self: None)
	adhesionHorizontalFalloffAngle = property(lambda self: None)
	adhesionPitchToYawRatio = property(lambda self: None)
	adhesionVerticalAngle = property(lambda self: None)
	adhesionVerticalFalloffAngle = property(lambda self: None)
	forwardAdhesion = property(lambda self: None)
	friction = property(lambda self: None)
	frictionDistance = property(lambda self: None)
	frictionFalloffDistance = property(lambda self: None)
	frictionHorizontalAngle = property(lambda self: None)
	frictionHorizontalFalloffAngle = property(lambda self: None)
	frictionMinimumDistance = property(lambda self: None)
	frictionVerticalAngle = property(lambda self: None)
	frictionVerticalFalloffAngle = property(lambda self: None)
	reverseAdhesionStyle = property(lambda self: None)
	strafeAdhesion = property(lambda self: None)
	turnAdhesion = property(lambda self: None)


class PyFilter(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def enableLagDetection(self, *args, **kwargs): pass
	def input(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	def output(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass


class AvatarFilter(PyFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'AvatarFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def callback(self, *args, **kwargs): pass
	def debugMatrixes(self, *args, **kwargs): pass
	def enableLagDetection(self, *args, **kwargs): pass
	def getLatency(self, *args, **kwargs): pass
	def getTimestamps(self, *args, **kwargs): pass
	def getVector3(self, *args, **kwargs): pass
	def input(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	latency = property(lambda self: None)
	latencyCurvePower = 2.0
	latencyFrames = 2.0
	minLatency = 0.10000000149011612
	def output(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass
	def resetVector3(self, *args, **kwargs): pass
	def setInterpolationType(self, *args, **kwargs): pass
	def syncVector3(self, *args, **kwargs): pass
	velLatency = 1.0


class AvatarDropFilter(AvatarFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'AvatarDropFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	alignToGround = property(lambda self: None)
	def callback(self, *args, **kwargs): pass
	def debugMatrixes(self, *args, **kwargs): pass
	def enableLagDetection(self, *args, **kwargs): pass
	def getLatency(self, *args, **kwargs): pass
	def getTimestamps(self, *args, **kwargs): pass
	def getVector3(self, *args, **kwargs): pass
	groundNormal = property(lambda self: None)
	def input(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	latency = property(lambda self: None)
	latencyCurvePower = 2.0
	latencyFrames = 2.0
	minLatency = 0.10000000149011612
	def output(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass
	def resetVector3(self, *args, **kwargs): pass
	def setInterpolationType(self, *args, **kwargs): pass
	def syncVector3(self, *args, **kwargs): pass
	velLatency = 1.0


class AvatarSubfilters(pybind11_object):
	CAMERA_ARTY_ROTATION = AvatarSubfilters.CAMERA_ARTY_ROTATION
	CAMERA_ARTY_SHOT_POINT = AvatarSubfilters.CAMERA_ARTY_SHOT_POINT
	CAMERA_ARTY_TRANSLATION = AvatarSubfilters.CAMERA_ARTY_TRANSLATION
	CAMERA_SHOT_POINT = AvatarSubfilters.CAMERA_SHOT_POINT
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  CAMERA_SHOT_POINT\n\n  CAMERA_ARTY_SHOT_POINT\n\n  CAMERA_ARTY_ROTATION\n\n  CAMERA_ARTY_TRANSLATION'
	__entries = {u'CAMERA_SHOT_POINT': (AvatarSubfilters.CAMERA_SHOT_POINT, None), u'CAMERA_ARTY_SHOT_POINT': (AvatarSubfilters.CAMERA_ARTY_SHOT_POINT, None), u'CAMERA_ARTY_ROTATION': (AvatarSubfilters.CAMERA_ARTY_ROTATION, None), u'CAMERA_ARTY_TRANSLATION': (AvatarSubfilters.CAMERA_ARTY_TRANSLATION, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'CAMERA_ARTY_ROTATION': AvatarSubfilters.CAMERA_ARTY_ROTATION, u'CAMERA_ARTY_SHOT_POINT': AvatarSubfilters.CAMERA_ARTY_SHOT_POINT, u'CAMERA_SHOT_POINT': AvatarSubfilters.CAMERA_SHOT_POINT, u'CAMERA_ARTY_TRANSLATION': AvatarSubfilters.CAMERA_ARTY_TRANSLATION}
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'AvatarSubfilters'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


class AxisEvent(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'AxisEvent'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	axis = property(lambda self: None)
	dTime = property(lambda self: None)
	value = property(lambda self: None)


class BW__DirectionCursor(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'BW::DirectionCursor'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def forceLookSpring(self, *args, **kwargs): pass
	invertVerticalMovement = property(lambda self: None)
	lookSpring = property(lambda self: None)
	lookSpringIdleTime = property(lambda self: None)
	lookSpringOnMove = property(lambda self: None)
	lookSpringRate = property(lambda self: None)
	matrix = property(lambda self: None)
	maxPitch = property(lambda self: None)
	maxYaw = property(lambda self: None)
	minPitch = property(lambda self: None)
	minYaw = property(lambda self: None)
	mouseHVBias = property(lambda self: None)
	mouseSensitivity = property(lambda self: None)
	pitch = property(lambda self: None)
	roll = property(lambda self: None)
	yaw = property(lambda self: None)
	def yawPitch(self, *args, **kwargs): pass
	yawReference = property(lambda self: None)


class InputHandler(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'InputHandler'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class BaseCamera(InputHandler):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'BaseCamera'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	direction = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	matrix = property(lambda self: None)
	position = property(lambda self: None)
	def render(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)
	def update(self, *args, **kwargs): pass


class BoidsFilter(AvatarFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'BoidsFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def callback(self, *args, **kwargs): pass
	collisionFraction = property(lambda self: None)
	deadZonePosition = property(lambda self: None)
	deadZoneRadius = property(lambda self: None)
	def debugMatrixes(self, *args, **kwargs): pass
	def enableLagDetection(self, *args, **kwargs): pass
	def getLatency(self, *args, **kwargs): pass
	def getTimestamps(self, *args, **kwargs): pass
	def getVector3(self, *args, **kwargs): pass
	goalApproachRadius = property(lambda self: None)
	goalStopRadius = property(lambda self: None)
	influenceRadius = property(lambda self: None)
	def input(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	latency = property(lambda self: None)
	latencyCurvePower = 2.0
	latencyFrames = 2.0
	maxRoll = property(lambda self: None)
	minLatency = 0.10000000149011612
	def output(self, *args, **kwargs): pass
	pitchToSpeedRatio = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	def resetVector3(self, *args, **kwargs): pass
	def setInterpolationType(self, *args, **kwargs): pass
	speed = property(lambda self: None)
	state = property(lambda self: None)
	def syncVector3(self, *args, **kwargs): pass
	velLatency = 1.0
	yprSpeed = property(lambda self: None)


class BorderlessBehaviour(pybind11_object):
	FULLSCREEN = BorderlessBehaviour.FULLSCREEN
	WINDOWED_FIXED_SIZE = BorderlessBehaviour.WINDOWED_FIXED_SIZE
	WINDOWED_UNCONSTRAINED = BorderlessBehaviour.WINDOWED_UNCONSTRAINED
	WORKAREA_MAXIMIZED = BorderlessBehaviour.WORKAREA_MAXIMIZED
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  FULLSCREEN\n\n  WINDOWED_FIXED_SIZE\n\n  WORKAREA_MAXIMIZED\n\n  WINDOWED_UNCONSTRAINED'
	__entries = {u'FULLSCREEN': (BorderlessBehaviour.FULLSCREEN, None), u'WINDOWED_FIXED_SIZE': (BorderlessBehaviour.WINDOWED_FIXED_SIZE, None), u'WORKAREA_MAXIMIZED': (BorderlessBehaviour.WORKAREA_MAXIMIZED, None), u'WINDOWED_UNCONSTRAINED': (BorderlessBehaviour.WINDOWED_UNCONSTRAINED, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'FULLSCREEN': BorderlessBehaviour.FULLSCREEN, u'WINDOWED_FIXED_SIZE': BorderlessBehaviour.WINDOWED_FIXED_SIZE, u'WORKAREA_MAXIMIZED': BorderlessBehaviour.WORKAREA_MAXIMIZED, u'WINDOWED_UNCONSTRAINED': BorderlessBehaviour.WINDOWED_UNCONSTRAINED}
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'BorderlessBehaviour'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


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


class BoxAttachment(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'BoxAttachment'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	attached = property(lambda self: None)
	castsShadow = property(lambda self: None)
	hit = property(lambda self: None)
	inWorld = property(lambda self: None)
	matrix = property(lambda self: None)
	maxBounds = property(lambda self: None)
	minBounds = property(lambda self: None)
	name = property(lambda self: None)
	worldTransform = property(lambda self: None)

CAMERA_ARTY_ROTATION = AvatarSubfilters.CAMERA_ARTY_ROTATION
CAMERA_ARTY_SHOT_POINT = AvatarSubfilters.CAMERA_ARTY_SHOT_POINT
CAMERA_ARTY_TRANSLATION = AvatarSubfilters.CAMERA_ARTY_TRANSLATION
CAMERA_SHOT_POINT = AvatarSubfilters.CAMERA_SHOT_POINT
CANCELLED = LOGIN_STATUS.CANCELLED
CONNECTION_FAILED = LOGIN_STATUS.CONNECTION_FAILED

class CameraSpeed(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CameraSpeed'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	accelerateEnd = property(lambda self: None)
	accelerateRate = property(lambda self: None)
	accelerateStart = property(lambda self: None)
	accelerateWhileTargeting = property(lambda self: None)
	cameraPitchSpeed = property(lambda self: None)
	cameraYawSpeed = property(lambda self: None)
	lookAxisMax = property(lambda self: None)
	lookAxisMin = property(lambda self: None)
	lookTable = property(lambda self: None)


class CollidableTransitionCamera(BaseCamera):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CollidableTransitionCamera'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	direction = property(lambda self: None)
	def finish(self, *args, **kwargs): pass
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	def isInTransition(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	position = property(lambda self: None)
	def positionEasingProgress(self, *args, **kwargs): pass
	def render(self, *args, **kwargs): pass
	def rotationEasingProgress(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)
	def start(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass


class CollideSegment(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CollideSegment'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	closestPoint = property(lambda self: None)
	def isTerrain(self, *args, **kwargs): pass
	matKind = property(lambda self: None)
	normal = property(lambda self: None)


class CustomRefLoader(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CustomRefLoader'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


class CollisionAssembler(CustomRefLoader):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CollisionAssembler'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


class PyComponentWrapperBase(pybind11_object):
	def __cmp__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyComponentWrapperBase'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def clear(self, *args, **kwargs): pass
	def destroy(self, *args, **kwargs): pass
	def id(self, *args, **kwargs): pass
	def valid(self, *args, **kwargs): pass


class CollisionComponent(PyComponentWrapperBase):
	def __cmp__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CollisionComponent'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addAttachment(self, *args, **kwargs): pass
	def addExtraAttachment(self, *args, **kwargs): pass
	def clear(self, *args, **kwargs): pass
	def collideAllWorld(self, *args, **kwargs): pass
	def collideLocal(self, *args, **kwargs): pass
	def collideLocalPoint(self, *args, **kwargs): pass
	def collideShape(self, *args, **kwargs): pass
	def collideWorld(self, *args, **kwargs): pass
	def connect(self, *args, **kwargs): pass
	def destroy(self, *args, **kwargs): pass
	def getBoundingBox(self, *args, **kwargs): pass
	def getColliderID(self, *args, **kwargs): pass
	def getColliderType(self, *args, **kwargs): pass
	def getPartName(self, *args, **kwargs): pass
	def id(self, *args, **kwargs): pass
	def removeAttachment(self, *args, **kwargs): pass
	def setColliderType(self, *args, **kwargs): pass
	def valid(self, *args, **kwargs): pass

ColorPassBit = 1

class CompoundAssembler(CustomRefLoader):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CompoundAssembler'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addNode(self, *args, **kwargs): pass
	def addNodeAlias(self, *args, **kwargs): pass
	def addPart(self, *args, **kwargs): pass
	def addRootPart(self, *args, **kwargs): pass
	def emplacePart(self, *args, **kwargs): pass
	def loadAndAssembleCompound(self, *args, **kwargs): pass
	lodIdx = property(lambda self: None)
	name = property(lambda self: None)
	skipMaterials = property(lambda self: None)
	spaceID = property(lambda self: None)


class CursorCamera(BaseCamera):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CursorCamera'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addVolumeGroup(self, *args, **kwargs): pass
	direction = property(lambda self: None)
	def enableAdvancedCollider(self, *args, **kwargs): pass
	def forceUpdate(self, *args, **kwargs): pass
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	isHangar = property(lambda self: None)
	isMovementEnabled = property(lambda self: None)
	matrix = property(lambda self: None)
	maxDistHalfLife = property(lambda self: None)
	movementHalfLife = property(lambda self: None)
	movementHalfLifeMultiplier = property(lambda self: None)
	movementMode = property(lambda self: None)
	pivotMaxDist = property(lambda self: None)
	pivotMinDist = property(lambda self: None)
	pivotPosition = property(lambda self: None)
	position = property(lambda self: None)
	def render(self, *args, **kwargs): pass
	reverseView = property(lambda self: None)
	def set(self, *args, **kwargs): pass
	def setDynamicCollisions(self, *args, **kwargs): pass
	source = property(lambda self: None)
	spaceID = property(lambda self: None)
	target = property(lambda self: None)
	targetMaxDist = property(lambda self: None)
	targetPivotPosition = property(lambda self: None)
	terrainMinDist = property(lambda self: None)
	turningHalfLife = property(lambda self: None)
	def update(self, *args, **kwargs): pass
	uprightDirection = property(lambda self: None)


class CustomizationEnvironment(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'CustomizationEnvironment'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def enable(self, *args, **kwargs): pass

D15S1 = ResourceFormat.D15S1
D16 = ResourceFormat.D16
D16_LOCKABLE = ResourceFormat.D16_LOCKABLE
D24S8 = ResourceFormat.D24S8
D24X4S4 = ResourceFormat.D24X4S4
D24X8 = ResourceFormat.D24X8
D32 = ResourceFormat.D32
D32F_LOCKABLE = ResourceFormat.D32F_LOCKABLE
DNS_LOOKUP_FAILED = LOGIN_STATUS.DNS_LOOKUP_FAILED
DXT1 = ResourceFormat.DXT1
DXT2 = ResourceFormat.DXT2
DXT3 = ResourceFormat.DXT3
DXT4 = ResourceFormat.DXT4
DXT5 = ResourceFormat.DXT5
DepthPassBit = 4

class Details(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Details'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	hostName = property(lambda self: None)
	ip = property(lambda self: None)
	ownerName = property(lambda self: None)
	port = property(lambda self: None)
	serverString = property(lambda self: None)
	spaceName = property(lambda self: None)
	uid = property(lambda self: None)
	universeName = property(lambda self: None)
	usersCount = property(lambda self: None)


class DetailsVector(pybind11_object):
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
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	__pybind11_module_local_v5_msvc__ = PyCapsule()
	__qualname__ = 'DetailsVector'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
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


class DiffDirProvider(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DiffDirProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)
	target = property(lambda self: None)

DrawAll = 7

class DualGunAimingSystem(IAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DualGunAimingSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def enableAutoRotation(self, *args, **kwargs): pass
	def enableHorizontalStabilizerRuntime(self, *args, **kwargs): pass
	def focusOnPos(self, *args, **kwargs): pass
	def forceFullStabilization(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	gunPitch = property(lambda self: None)
	def handleMovement(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def onActiveGunChanged(self, *args, **kwargs): pass
	def onSiegeStateChanged(self, *args, **kwargs): pass
	def overrideZoom(self, *args, **kwargs): pass
	def resetIdealDirection(self, *args, **kwargs): pass
	def setAimingLimits(self, *args, **kwargs): pass
	def setTransitionDelay(*args, **kwargs): pass
	def setTransitionTime(*args, **kwargs): pass
	turretYaw = property(lambda self: None)
	def update(self, *args, **kwargs): pass


class DualGunAimingSystemRemote(DualGunAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DualGunAimingSystemRemote'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def enableAutoRotation(self, *args, **kwargs): pass
	def enableHorizontalStabilizerRuntime(self, *args, **kwargs): pass
	def focusOnPos(self, *args, **kwargs): pass
	def forceFullStabilization(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	gunPitch = property(lambda self: None)
	def handleMovement(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def onActiveGunChanged(self, *args, **kwargs): pass
	def onSiegeStateChanged(self, *args, **kwargs): pass
	def overrideZoom(self, *args, **kwargs): pass
	def resetIdealDirection(self, *args, **kwargs): pass
	def setAimingLimits(self, *args, **kwargs): pass
	def setTransitionDelay(*args, **kwargs): pass
	def setTransitionTime(*args, **kwargs): pass
	turretYaw = property(lambda self: None)
	def update(self, *args, **kwargs): pass


class DumbFilter(PyFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DumbFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def enableLagDetection(self, *args, **kwargs): pass
	def input(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	def output(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass


class PyObjectPlus(object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__members__ = property(lambda self: None)
	__methods__ = property(lambda self: None)
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class PyDynamicComponent(PyObjectPlus):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__members__ = property(lambda self: None)
	__methods__ = property(lambda self: None)
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	entity = property(lambda self: None)


class DynamicScriptComponent(PyDynamicComponent):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__members__ = property(lambda self: None)
	__methods__ = property(lambda self: None)
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	cell = property(lambda self: None)
	entity = property(lambda self: None)


class Entity(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__members__ = property(lambda self: None)
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Entity'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addModel(self, *args, **kwargs): pass
	aoiEntities = property(lambda self: None)
	base = property(lambda self: None)
	cell = property(lambda self: None)
	components = property(lambda self: None)
	def delModel(self, *args, **kwargs): pass
	dynamicComponents = property(lambda self: None)
	entityGameObject = property(lambda self: None)
	filter = property(lambda self: None)
	def hasTargetCap(self, *args, **kwargs): pass
	id = property(lambda self: None)
	inWorld = property(lambda self: None)
	isClientOnly = property(lambda self: None)
	isDestroyed = property(lambda self: None)
	isPlayer = property(lambda self: None)
	isPoseVolatile = property(lambda self: None)
	isWitness = property(lambda self: None)
	matrix = property(lambda self: None)
	model = property(lambda self: None)
	models = property(lambda self: None)
	pitch = property(lambda self: None)
	position = property(lambda self: None)
	def prints(self, *args, **kwargs): pass
	roll = property(lambda self: None)
	spaceID = property(lambda self: None)
	staticComponents = property(lambda self: None)
	targetCaps = property(lambda self: None)
	targetFullBounds = property(lambda self: None)
	def teleport(self, *args, **kwargs): pass
	vehicle = property(lambda self: None)
	velocity = property(lambda self: None)
	yaw = property(lambda self: None)


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


class EntityDestroyedException(Exception):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
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
	message = property(lambda self: None)


class EntityDirProvider(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'EntityDirProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)


class EntityEmbodiments(pybind11_object):
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
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	__pybind11_module_local_v5_msvc__ = PyCapsule()
	__qualname__ = 'EntityEmbodiments'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
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


class EntityMProv(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'EntityMProv'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class EnvironmentSwitcher(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'EnvironmentSwitcher'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def enable(self, *args, **kwargs): pass


class EventType(pybind11_object):
	LOADING_VIEW = EventType.LOADING_VIEW
	LOAD_FAILED = EventType.LOAD_FAILED
	VIEW_CREATED = EventType.VIEW_CREATED
	VIEW_DESTROYED = EventType.VIEW_DESTROYED
	VIEW_LOADED = EventType.VIEW_LOADED
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  LOADING_VIEW\n\n  VIEW_DESTROYED\n\n  VIEW_LOADED\n\n  LOAD_FAILED\n\n  VIEW_CREATED'
	__entries = {u'LOADING_VIEW': (EventType.LOADING_VIEW, None), u'VIEW_DESTROYED': (EventType.VIEW_DESTROYED, None), u'VIEW_LOADED': (EventType.VIEW_LOADED, None), u'LOAD_FAILED': (EventType.LOAD_FAILED, None), u'VIEW_CREATED': (EventType.VIEW_CREATED, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'LOADING_VIEW': EventType.LOADING_VIEW, u'VIEW_DESTROYED': EventType.VIEW_DESTROYED, u'VIEW_LOADED': EventType.VIEW_LOADED, u'LOAD_FAILED': EventType.LOAD_FAILED, u'VIEW_CREATED': EventType.VIEW_CREATED}
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'EventType'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)

FULLSCREEN = BorderlessBehaviour.FULLSCREEN

class FailedUnpickle(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'FailedUnpickle'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class FilterInterpolationType(pybind11_object):
	ANGLE_RADIANS = FilterInterpolationType.ANGLE_RADIANS
	LINEAR = FilterInterpolationType.LINEAR
	SLERP_OF_CARTESIAN = FilterInterpolationType.SLERP_OF_CARTESIAN
	SPHERICAL_RADIANS = FilterInterpolationType.SPHERICAL_RADIANS
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  SLERP_OF_CARTESIAN\n\n  ANGLE_RADIANS\n\n  LINEAR\n\n  SPHERICAL_RADIANS'
	__entries = {u'SLERP_OF_CARTESIAN': (FilterInterpolationType.SLERP_OF_CARTESIAN, None), u'ANGLE_RADIANS': (FilterInterpolationType.ANGLE_RADIANS, None), u'LINEAR': (FilterInterpolationType.LINEAR, None), u'SPHERICAL_RADIANS': (FilterInterpolationType.SPHERICAL_RADIANS, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'SLERP_OF_CARTESIAN': FilterInterpolationType.SLERP_OF_CARTESIAN, u'ANGLE_RADIANS': FilterInterpolationType.ANGLE_RADIANS, u'LINEAR': FilterInterpolationType.LINEAR, u'SPHERICAL_RADIANS': FilterInterpolationType.SPHERICAL_RADIANS}
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'FilterInterpolationType'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


class FlexiCam(BaseCamera):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'FlexiCam'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	actualDir = property(lambda self: None)
	actualPos = property(lambda self: None)
	direction = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	matrix = property(lambda self: None)
	position = property(lambda self: None)
	positionAcceleration = property(lambda self: None)
	preferredPitch = property(lambda self: None)
	preferredPos = property(lambda self: None)
	preferredYaw = property(lambda self: None)
	def render(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)
	target = property(lambda self: None)
	timeMultiplier = property(lambda self: None)
	trackingAcceleration = property(lambda self: None)
	def update(self, *args, **kwargs): pass
	uprightDir = property(lambda self: None)
	viewOffset = property(lambda self: None)


class SpeedTreeTargetedCamera(BaseCamera):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SpeedTreeTargetedCamera'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	direction = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	matrix = property(lambda self: None)
	position = property(lambda self: None)
	def render(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)
	speedTreeTarget = property(lambda self: None)
	def update(self, *args, **kwargs): pass


class FreeCamera(SpeedTreeTargetedCamera):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'FreeCamera'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	direction = property(lambda self: None)
	fixed = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	invViewProvider = property(lambda self: None)
	matrix = property(lambda self: None)
	position = property(lambda self: None)
	def render(self, *args, **kwargs): pass
	def resetKeys(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)
	speedTreeTarget = property(lambda self: None)
	def update(self, *args, **kwargs): pass

G16R16 = ResourceFormat.G16R16
G16R16F = ResourceFormat.G16R16F
G32R32F = ResourceFormat.G32R32F

class GroundNormalProvider(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'GroundNormalProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	avatarDropFilter = property(lambda self: None)


class Motor(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Motor'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	owner = property(lambda self: None)


class Homer(Motor):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Homer'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	arrivalCountLimit = property(lambda self: None)
	goneTime = property(lambda self: None)
	owner = property(lambda self: None)
	proximity = property(lambda self: None)
	proximityCallback = property(lambda self: None)
	scale = property(lambda self: None)
	scaleTime = property(lambda self: None)
	speed = property(lambda self: None)
	target = property(lambda self: None)
	tripTime = property(lambda self: None)
	turnAxis = property(lambda self: None)
	turnRate = property(lambda self: None)
	zenithed = property(lambda self: None)


class HomingCamera(SpeedTreeTargetedCamera):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'HomingCamera'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addVolumeGroup(self, *args, **kwargs): pass
	aimPointClipCoords = property(lambda self: None)
	aimPointProvider = property(lambda self: None)
	cameraPositionProvider = property(lambda self: None)
	direction = property(lambda self: None)
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	def hasCollision(self, *args, **kwargs): pass
	def initAdvancedCollider(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	def isColliding(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	pivotPositionProvider = property(lambda self: None)
	position = property(lambda self: None)
	def render(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	def setCollisionCheckOnlyAtPos(self, *args, **kwargs): pass
	def setDynamicCollisions(self, *args, **kwargs): pass
	def setScrollDelta(self, *args, **kwargs): pass
	def shiftCamera(self, *args, **kwargs): pass
	def shiftPivotPos(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)
	speedTreeTarget = property(lambda self: None)
	up = property(lambda self: None)
	def update(self, *args, **kwargs): pass


class PyFashion(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class TransformMaterialFashion(PyFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'TransformMaterialFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class ICompoundFashion(TransformMaterialFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ICompoundFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class IMEEvent(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'IMEEvent'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	candidatesChanged = property(lambda self: None)
	candidatesVisibilityChanged = property(lambda self: None)
	compositionChanged = property(lambda self: None)
	compositionCursorPositionChanged = property(lambda self: None)
	readingChanged = property(lambda self: None)
	readingVisibilityChanged = property(lambda self: None)
	selectedCandidateChanged = property(lambda self: None)
	stateChanged = property(lambda self: None)

IS_CONSUMER_CLIENT_BUILD = True

class ITextureProvider(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ITextureProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class InvViewMatrix(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'InvViewMatrix'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class KeyEvent(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'KeyEvent'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	character = property(lambda self: None)
	cursorPosition = property(lambda self: None)
	def isAltDown(self, *args, **kwargs): pass
	def isCtrlDown(self, *args, **kwargs): pass
	def isKeyDown(self, *args, **kwargs): pass
	def isKeyUp(self, *args, **kwargs): pass
	def isModifierDown(self, *args, **kwargs): pass
	def isMouseButton(self, *args, **kwargs): pass
	def isRepeatedEvent(self, *args, **kwargs): pass
	def isShiftDown(self, *args, **kwargs): pass
	key = property(lambda self: None)
	modifiers = property(lambda self: None)
	repeatCount = property(lambda self: None)

L16 = ResourceFormat.L16
L8 = ResourceFormat.L8
LAST_CLIENT_SIDE_VALUE = LOGIN_STATUS.LAST_CLIENT_SIDE_VALUE
LAST_SERVER_SIDE_VALUE = LOGIN_STATUS.LAST_SERVER_SIDE_VALUE
LINEAR = FilterInterpolationType.LINEAR
LOADING_VIEW = EventType.LOADING_VIEW
LOAD_FAILED = EventType.LOAD_FAILED
LOGGED_ON = LOGIN_STATUS.LOGGED_ON
LOGGED_ON_OFFLINE = LOGIN_STATUS.LOGGED_ON_OFFLINE
LOGIN_BAD_PROTOCOL_VERSION = LOGIN_STATUS.LOGIN_BAD_PROTOCOL_VERSION
LOGIN_CUSTOM_DEFINED_ERROR = LOGIN_STATUS.LOGIN_CUSTOM_DEFINED_ERROR
LOGIN_MALFORMED_REQUEST = LOGIN_STATUS.LOGIN_MALFORMED_REQUEST
LOGIN_REJECTED_ACTIVATING = LOGIN_STATUS.LOGIN_REJECTED_ACTIVATING
LOGIN_REJECTED_ALREADY_LOGGED_IN = LOGIN_STATUS.LOGIN_REJECTED_ALREADY_LOGGED_IN
LOGIN_REJECTED_AUTH_SERVICE_GENERAL_FAILURE = LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_GENERAL_FAILURE
LOGIN_REJECTED_AUTH_SERVICE_INVALID_RESPONSE = LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_INVALID_RESPONSE
LOGIN_REJECTED_AUTH_SERVICE_LOGIN_DISALLOWED = LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_LOGIN_DISALLOWED
LOGIN_REJECTED_AUTH_SERVICE_NO_SUCH_ACCOUNT = LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_NO_SUCH_ACCOUNT
LOGIN_REJECTED_AUTH_SERVICE_UNREACHABLE = LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_UNREACHABLE
LOGIN_REJECTED_BAD_DIGEST = LOGIN_STATUS.LOGIN_REJECTED_BAD_DIGEST
LOGIN_REJECTED_BAN = LOGIN_STATUS.LOGIN_REJECTED_BAN
LOGIN_REJECTED_BASEAPPMGR_TIMEOUT = LOGIN_STATUS.LOGIN_REJECTED_BASEAPPMGR_TIMEOUT
LOGIN_REJECTED_BASEAPP_OVERLOAD = LOGIN_STATUS.LOGIN_REJECTED_BASEAPP_OVERLOAD
LOGIN_REJECTED_BASEAPP_TIMEOUT = LOGIN_STATUS.LOGIN_REJECTED_BASEAPP_TIMEOUT
LOGIN_REJECTED_CELLAPP_OVERLOAD = LOGIN_STATUS.LOGIN_REJECTED_CELLAPP_OVERLOAD
LOGIN_REJECTED_CHALLENGE_ERROR = LOGIN_STATUS.LOGIN_REJECTED_CHALLENGE_ERROR
LOGIN_REJECTED_DBAPP_OVERLOAD = LOGIN_STATUS.LOGIN_REJECTED_DBAPP_OVERLOAD
LOGIN_REJECTED_DB_GENERAL_FAILURE = LOGIN_STATUS.LOGIN_REJECTED_DB_GENERAL_FAILURE
LOGIN_REJECTED_DB_NOT_READY = LOGIN_STATUS.LOGIN_REJECTED_DB_NOT_READY
LOGIN_REJECTED_ILLEGAL_CHARACTERS = LOGIN_STATUS.LOGIN_REJECTED_ILLEGAL_CHARACTERS
LOGIN_REJECTED_INACCESSIBLE_REALM = LOGIN_STATUS.LOGIN_REJECTED_INACCESSIBLE_REALM
LOGIN_REJECTED_INVALID_PASSWORD = LOGIN_STATUS.LOGIN_REJECTED_INVALID_PASSWORD
LOGIN_REJECTED_IP_ADDRESS_BAN = LOGIN_STATUS.LOGIN_REJECTED_IP_ADDRESS_BAN
LOGIN_REJECTED_LOGINS_NOT_ALLOWED = LOGIN_STATUS.LOGIN_REJECTED_LOGINS_NOT_ALLOWED
LOGIN_REJECTED_LOGIN_QUEUE = LOGIN_STATUS.LOGIN_REJECTED_LOGIN_QUEUE
LOGIN_REJECTED_NOT_REGISTERED = LOGIN_STATUS.LOGIN_REJECTED_NOT_REGISTERED
LOGIN_REJECTED_NO_BASEAPPS = LOGIN_STATUS.LOGIN_REJECTED_NO_BASEAPPS
LOGIN_REJECTED_NO_BASEAPP_RESPONSE = LOGIN_STATUS.LOGIN_REJECTED_NO_BASEAPP_RESPONSE
LOGIN_REJECTED_NO_LOGINAPP = LOGIN_STATUS.LOGIN_REJECTED_NO_LOGINAPP
LOGIN_REJECTED_NO_LOGINAPP_RESPONSE = LOGIN_STATUS.LOGIN_REJECTED_NO_LOGINAPP_RESPONSE
LOGIN_REJECTED_NO_SUCH_USER = LOGIN_STATUS.LOGIN_REJECTED_NO_SUCH_USER
LOGIN_REJECTED_RATE_LIMITED = LOGIN_STATUS.LOGIN_REJECTED_RATE_LIMITED
LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED = LOGIN_STATUS.LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED
LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED = LOGIN_STATUS.LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED
LOGIN_REJECTED_SERVER_NOT_READY = LOGIN_STATUS.LOGIN_REJECTED_SERVER_NOT_READY
LOGIN_REJECTED_UNABLE_TO_PARSE_JSON = LOGIN_STATUS.LOGIN_REJECTED_UNABLE_TO_PARSE_JSON
LOGIN_REJECTED_UPDATER_NOT_READY = LOGIN_STATUS.LOGIN_REJECTED_UPDATER_NOT_READY
LOGIN_REJECTED_USERS_LIMIT = LOGIN_STATUS.LOGIN_REJECTED_USERS_LIMIT

class LOGIN_STATUS(pybind11_object):
	ALREADY_ONLINE_LOCALLY = LOGIN_STATUS.ALREADY_ONLINE_LOCALLY
	CANCELLED = LOGIN_STATUS.CANCELLED
	CONNECTION_FAILED = LOGIN_STATUS.CONNECTION_FAILED
	DNS_LOOKUP_FAILED = LOGIN_STATUS.DNS_LOOKUP_FAILED
	LAST_CLIENT_SIDE_VALUE = LOGIN_STATUS.LAST_CLIENT_SIDE_VALUE
	LAST_SERVER_SIDE_VALUE = LOGIN_STATUS.LAST_SERVER_SIDE_VALUE
	LOGGED_ON = LOGIN_STATUS.LOGGED_ON
	LOGGED_ON_OFFLINE = LOGIN_STATUS.LOGGED_ON_OFFLINE
	LOGIN_BAD_PROTOCOL_VERSION = LOGIN_STATUS.LOGIN_BAD_PROTOCOL_VERSION
	LOGIN_CUSTOM_DEFINED_ERROR = LOGIN_STATUS.LOGIN_CUSTOM_DEFINED_ERROR
	LOGIN_MALFORMED_REQUEST = LOGIN_STATUS.LOGIN_MALFORMED_REQUEST
	LOGIN_REJECTED_ACTIVATING = LOGIN_STATUS.LOGIN_REJECTED_ACTIVATING
	LOGIN_REJECTED_ALREADY_LOGGED_IN = LOGIN_STATUS.LOGIN_REJECTED_ALREADY_LOGGED_IN
	LOGIN_REJECTED_AUTH_SERVICE_GENERAL_FAILURE = LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_GENERAL_FAILURE
	LOGIN_REJECTED_AUTH_SERVICE_INVALID_RESPONSE = LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_INVALID_RESPONSE
	LOGIN_REJECTED_AUTH_SERVICE_LOGIN_DISALLOWED = LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_LOGIN_DISALLOWED
	LOGIN_REJECTED_AUTH_SERVICE_NO_SUCH_ACCOUNT = LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_NO_SUCH_ACCOUNT
	LOGIN_REJECTED_AUTH_SERVICE_UNREACHABLE = LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_UNREACHABLE
	LOGIN_REJECTED_BAD_DIGEST = LOGIN_STATUS.LOGIN_REJECTED_BAD_DIGEST
	LOGIN_REJECTED_BAN = LOGIN_STATUS.LOGIN_REJECTED_BAN
	LOGIN_REJECTED_BASEAPPMGR_TIMEOUT = LOGIN_STATUS.LOGIN_REJECTED_BASEAPPMGR_TIMEOUT
	LOGIN_REJECTED_BASEAPP_OVERLOAD = LOGIN_STATUS.LOGIN_REJECTED_BASEAPP_OVERLOAD
	LOGIN_REJECTED_BASEAPP_TIMEOUT = LOGIN_STATUS.LOGIN_REJECTED_BASEAPP_TIMEOUT
	LOGIN_REJECTED_CELLAPP_OVERLOAD = LOGIN_STATUS.LOGIN_REJECTED_CELLAPP_OVERLOAD
	LOGIN_REJECTED_CHALLENGE_ERROR = LOGIN_STATUS.LOGIN_REJECTED_CHALLENGE_ERROR
	LOGIN_REJECTED_DBAPP_OVERLOAD = LOGIN_STATUS.LOGIN_REJECTED_DBAPP_OVERLOAD
	LOGIN_REJECTED_DB_GENERAL_FAILURE = LOGIN_STATUS.LOGIN_REJECTED_DB_GENERAL_FAILURE
	LOGIN_REJECTED_DB_NOT_READY = LOGIN_STATUS.LOGIN_REJECTED_DB_NOT_READY
	LOGIN_REJECTED_ILLEGAL_CHARACTERS = LOGIN_STATUS.LOGIN_REJECTED_ILLEGAL_CHARACTERS
	LOGIN_REJECTED_INACCESSIBLE_REALM = LOGIN_STATUS.LOGIN_REJECTED_INACCESSIBLE_REALM
	LOGIN_REJECTED_INVALID_PASSWORD = LOGIN_STATUS.LOGIN_REJECTED_INVALID_PASSWORD
	LOGIN_REJECTED_IP_ADDRESS_BAN = LOGIN_STATUS.LOGIN_REJECTED_IP_ADDRESS_BAN
	LOGIN_REJECTED_LOGINS_NOT_ALLOWED = LOGIN_STATUS.LOGIN_REJECTED_LOGINS_NOT_ALLOWED
	LOGIN_REJECTED_LOGIN_QUEUE = LOGIN_STATUS.LOGIN_REJECTED_LOGIN_QUEUE
	LOGIN_REJECTED_NOT_REGISTERED = LOGIN_STATUS.LOGIN_REJECTED_NOT_REGISTERED
	LOGIN_REJECTED_NO_BASEAPPS = LOGIN_STATUS.LOGIN_REJECTED_NO_BASEAPPS
	LOGIN_REJECTED_NO_BASEAPP_RESPONSE = LOGIN_STATUS.LOGIN_REJECTED_NO_BASEAPP_RESPONSE
	LOGIN_REJECTED_NO_LOGINAPP = LOGIN_STATUS.LOGIN_REJECTED_NO_LOGINAPP
	LOGIN_REJECTED_NO_LOGINAPP_RESPONSE = LOGIN_STATUS.LOGIN_REJECTED_NO_LOGINAPP_RESPONSE
	LOGIN_REJECTED_NO_SUCH_USER = LOGIN_STATUS.LOGIN_REJECTED_NO_SUCH_USER
	LOGIN_REJECTED_RATE_LIMITED = LOGIN_STATUS.LOGIN_REJECTED_RATE_LIMITED
	LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED = LOGIN_STATUS.LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED
	LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED = LOGIN_STATUS.LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED
	LOGIN_REJECTED_SERVER_NOT_READY = LOGIN_STATUS.LOGIN_REJECTED_SERVER_NOT_READY
	LOGIN_REJECTED_UNABLE_TO_PARSE_JSON = LOGIN_STATUS.LOGIN_REJECTED_UNABLE_TO_PARSE_JSON
	LOGIN_REJECTED_UPDATER_NOT_READY = LOGIN_STATUS.LOGIN_REJECTED_UPDATER_NOT_READY
	LOGIN_REJECTED_USERS_LIMIT = LOGIN_STATUS.LOGIN_REJECTED_USERS_LIMIT
	NOT_SET = LOGIN_STATUS.NOT_SET
	PUBLIC_KEY_LOOKUP_FAILED = LOGIN_STATUS.PUBLIC_KEY_LOOKUP_FAILED
	UNKNOWN_ERROR = LOGIN_STATUS.UNKNOWN_ERROR
	def __deepcopy__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  LOGIN_REJECTED_BASEAPP_OVERLOAD\n\n  LOGGED_ON\n\n  LOGIN_REJECTED_INACCESSIBLE_REALM\n\n  LOGIN_REJECTED_AUTH_SERVICE_LOGIN_DISALLOWED\n\n  UNKNOWN_ERROR\n\n  LOGIN_REJECTED_NO_BASEAPPS\n\n  LOGIN_REJECTED_BAN\n\n  LOGIN_REJECTED_BASEAPPMGR_TIMEOUT\n\n  LOGIN_REJECTED_AUTH_SERVICE_INVALID_RESPONSE\n\n  LOGIN_REJECTED_AUTH_SERVICE_NO_SUCH_ACCOUNT\n\n  LOGIN_REJECTED_AUTH_SERVICE_GENERAL_FAILURE\n\n  LOGIN_REJECTED_DB_NOT_READY\n\n  LOGIN_REJECTED_UNABLE_TO_PARSE_JSON\n\n  LOGIN_REJECTED_INVALID_PASSWORD\n\n  LOGIN_REJECTED_NOT_REGISTERED\n\n  LOGIN_REJECTED_NO_LOGINAPP_RESPONSE\n\n  LOGIN_REJECTED_NO_BASEAPP_RESPONSE\n\n  CANCELLED\n\n  LOGIN_BAD_PROTOCOL_VERSION\n\n  LOGIN_REJECTED_DB_GENERAL_FAILURE\n\n  LOGIN_REJECTED_LOGIN_QUEUE\n\n  CONNECTION_FAILED\n\n  LOGIN_REJECTED_ILLEGAL_CHARACTERS\n\n  LOGIN_REJECTED_LOGINS_NOT_ALLOWED\n\n  LAST_CLIENT_SIDE_VALUE\n\n  LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED\n\n  LOGIN_REJECTED_BAD_DIGEST\n\n  LOGIN_REJECTED_USERS_LIMIT\n\n  LOGIN_REJECTED_ACTIVATING\n\n  LOGIN_REJECTED_BASEAPP_TIMEOUT\n\n  LOGIN_MALFORMED_REQUEST\n\n  LOGIN_REJECTED_RATE_LIMITED\n\n  LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED\n\n  LOGIN_REJECTED_SERVER_NOT_READY\n\n  LAST_SERVER_SIDE_VALUE\n\n  LOGIN_REJECTED_AUTH_SERVICE_UNREACHABLE\n\n  LOGIN_REJECTED_IP_ADDRESS_BAN\n\n  LOGGED_ON_OFFLINE\n\n  PUBLIC_KEY_LOOKUP_FAILED\n\n  LOGIN_REJECTED_NO_SUCH_USER\n\n  DNS_LOOKUP_FAILED\n\n  ALREADY_ONLINE_LOCALLY\n\n  LOGIN_REJECTED_NO_LOGINAPP\n\n  NOT_SET\n\n  LOGIN_REJECTED_CELLAPP_OVERLOAD\n\n  LOGIN_REJECTED_CHALLENGE_ERROR\n\n  LOGIN_REJECTED_ALREADY_LOGGED_IN\n\n  LOGIN_CUSTOM_DEFINED_ERROR\n\n  LOGIN_REJECTED_DBAPP_OVERLOAD\n\n  LOGIN_REJECTED_UPDATER_NOT_READY'
	__entries = {u'LOGIN_REJECTED_BASEAPP_OVERLOAD': (LOGIN_STATUS.LOGIN_REJECTED_BASEAPP_OVERLOAD, None), u'LOGGED_ON': (LOGIN_STATUS.LOGGED_ON, None), u'LOGIN_REJECTED_INACCESSIBLE_REALM': (LOGIN_STATUS.LOGIN_REJECTED_INACCESSIBLE_REALM, None), u'LOGIN_REJECTED_AUTH_SERVICE_LOGIN_DISALLOWED': (LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_LOGIN_DISALLOWED, None), u'UNKNOWN_ERROR': (LOGIN_STATUS.UNKNOWN_ERROR, None), u'LOGIN_REJECTED_NO_BASEAPPS': (LOGIN_STATUS.LOGIN_REJECTED_NO_BASEAPPS, None), u'LOGIN_REJECTED_BAN': (LOGIN_STATUS.LOGIN_REJECTED_BAN, None), u'LOGIN_REJECTED_BASEAPPMGR_TIMEOUT': (LOGIN_STATUS.LOGIN_REJECTED_BASEAPPMGR_TIMEOUT, None), u'LOGIN_REJECTED_AUTH_SERVICE_INVALID_RESPONSE': (LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_INVALID_RESPONSE, None), u'LOGIN_REJECTED_AUTH_SERVICE_NO_SUCH_ACCOUNT': (LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_NO_SUCH_ACCOUNT, None), u'LOGIN_REJECTED_AUTH_SERVICE_GENERAL_FAILURE': (LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_GENERAL_FAILURE, None), u'LOGIN_REJECTED_DB_NOT_READY': (LOGIN_STATUS.LOGIN_REJECTED_DB_NOT_READY, None), u'LOGIN_REJECTED_UNABLE_TO_PARSE_JSON': (LOGIN_STATUS.LOGIN_REJECTED_UNABLE_TO_PARSE_JSON, None), u'LOGIN_REJECTED_INVALID_PASSWORD': (LOGIN_STATUS.LOGIN_REJECTED_INVALID_PASSWORD, None), u'LOGIN_REJECTED_NOT_REGISTERED': (LOGIN_STATUS.LOGIN_REJECTED_NOT_REGISTERED, None), u'LOGIN_REJECTED_NO_LOGINAPP_RESPONSE': (LOGIN_STATUS.LOGIN_REJECTED_NO_LOGINAPP_RESPONSE, None), u'LOGIN_REJECTED_NO_BASEAPP_RESPONSE': (LOGIN_STATUS.LOGIN_REJECTED_NO_BASEAPP_RESPONSE, None), u'CANCELLED': (LOGIN_STATUS.CANCELLED, None), u'LOGIN_BAD_PROTOCOL_VERSION': (LOGIN_STATUS.LOGIN_BAD_PROTOCOL_VERSION, None), u'LOGIN_REJECTED_DB_GENERAL_FAILURE': (LOGIN_STATUS.LOGIN_REJECTED_DB_GENERAL_FAILURE, None), u'LOGIN_REJECTED_LOGIN_QUEUE': (LOGIN_STATUS.LOGIN_REJECTED_LOGIN_QUEUE, None), u'CONNECTION_FAILED': (LOGIN_STATUS.CONNECTION_FAILED, None), u'LOGIN_REJECTED_ILLEGAL_CHARACTERS': (LOGIN_STATUS.LOGIN_REJECTED_ILLEGAL_CHARACTERS, None), u'LOGIN_REJECTED_LOGINS_NOT_ALLOWED': (LOGIN_STATUS.LOGIN_REJECTED_LOGINS_NOT_ALLOWED, None), u'LAST_CLIENT_SIDE_VALUE': (LOGIN_STATUS.LAST_CLIENT_SIDE_VALUE, None), u'LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED': (LOGIN_STATUS.LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED, None), u'LOGIN_REJECTED_BAD_DIGEST': (LOGIN_STATUS.LOGIN_REJECTED_BAD_DIGEST, None), u'LOGIN_REJECTED_USERS_LIMIT': (LOGIN_STATUS.LOGIN_REJECTED_USERS_LIMIT, None), u'LOGIN_REJECTED_ACTIVATING': (LOGIN_STATUS.LOGIN_REJECTED_ACTIVATING, None), u'LOGIN_REJECTED_BASEAPP_TIMEOUT': (LOGIN_STATUS.LOGIN_REJECTED_BASEAPP_TIMEOUT, None), u'LOGIN_MALFORMED_REQUEST': (LOGIN_STATUS.LOGIN_MALFORMED_REQUEST, None), u'LOGIN_REJECTED_RATE_LIMITED': (LOGIN_STATUS.LOGIN_REJECTED_RATE_LIMITED, None), u'LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED': (LOGIN_STATUS.LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED, None), u'LOGIN_REJECTED_SERVER_NOT_READY': (LOGIN_STATUS.LOGIN_REJECTED_SERVER_NOT_READY, None), u'LAST_SERVER_SIDE_VALUE': (LOGIN_STATUS.LAST_SERVER_SIDE_VALUE, None), u'LOGIN_REJECTED_AUTH_SERVICE_UNREACHABLE': (LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_UNREACHABLE, None), u'LOGIN_REJECTED_IP_ADDRESS_BAN': (LOGIN_STATUS.LOGIN_REJECTED_IP_ADDRESS_BAN, None), u'LOGGED_ON_OFFLINE': (LOGIN_STATUS.LOGGED_ON_OFFLINE, None), u'PUBLIC_KEY_LOOKUP_FAILED': (LOGIN_STATUS.PUBLIC_KEY_LOOKUP_FAILED, None), u'LOGIN_REJECTED_NO_SUCH_USER': (LOGIN_STATUS.LOGIN_REJECTED_NO_SUCH_USER, None), u'DNS_LOOKUP_FAILED': (LOGIN_STATUS.DNS_LOOKUP_FAILED, None), u'ALREADY_ONLINE_LOCALLY': (LOGIN_STATUS.ALREADY_ONLINE_LOCALLY, None), u'LOGIN_REJECTED_NO_LOGINAPP': (LOGIN_STATUS.LOGIN_REJECTED_NO_LOGINAPP, None), u'NOT_SET': (LOGIN_STATUS.NOT_SET, None), u'LOGIN_REJECTED_CELLAPP_OVERLOAD': (LOGIN_STATUS.LOGIN_REJECTED_CELLAPP_OVERLOAD, None), u'LOGIN_REJECTED_CHALLENGE_ERROR': (LOGIN_STATUS.LOGIN_REJECTED_CHALLENGE_ERROR, None), u'LOGIN_REJECTED_ALREADY_LOGGED_IN': (LOGIN_STATUS.LOGIN_REJECTED_ALREADY_LOGGED_IN, None), u'LOGIN_CUSTOM_DEFINED_ERROR': (LOGIN_STATUS.LOGIN_CUSTOM_DEFINED_ERROR, None), u'LOGIN_REJECTED_DBAPP_OVERLOAD': (LOGIN_STATUS.LOGIN_REJECTED_DBAPP_OVERLOAD, None), u'LOGIN_REJECTED_UPDATER_NOT_READY': (LOGIN_STATUS.LOGIN_REJECTED_UPDATER_NOT_READY, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'LOGIN_REJECTED_BASEAPP_OVERLOAD': LOGIN_STATUS.LOGIN_REJECTED_BASEAPP_OVERLOAD, u'LOGGED_ON': LOGIN_STATUS.LOGGED_ON, u'LOGIN_REJECTED_AUTH_SERVICE_LOGIN_DISALLOWED': LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_LOGIN_DISALLOWED, u'UNKNOWN_ERROR': LOGIN_STATUS.UNKNOWN_ERROR, u'LOGIN_REJECTED_UNABLE_TO_PARSE_JSON': LOGIN_STATUS.LOGIN_REJECTED_UNABLE_TO_PARSE_JSON, u'DNS_LOOKUP_FAILED': LOGIN_STATUS.DNS_LOOKUP_FAILED, u'LOGIN_REJECTED_NO_LOGINAPP_RESPONSE': LOGIN_STATUS.LOGIN_REJECTED_NO_LOGINAPP_RESPONSE, u'LOGIN_REJECTED_NO_BASEAPPS': LOGIN_STATUS.LOGIN_REJECTED_NO_BASEAPPS, u'LOGIN_REJECTED_AUTH_SERVICE_INVALID_RESPONSE': LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_INVALID_RESPONSE, u'LOGIN_REJECTED_AUTH_SERVICE_NO_SUCH_ACCOUNT': LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_NO_SUCH_ACCOUNT, u'LOGIN_REJECTED_AUTH_SERVICE_UNREACHABLE': LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_UNREACHABLE, u'LOGIN_REJECTED_DB_NOT_READY': LOGIN_STATUS.LOGIN_REJECTED_DB_NOT_READY, u'LOGIN_REJECTED_ALREADY_LOGGED_IN': LOGIN_STATUS.LOGIN_REJECTED_ALREADY_LOGGED_IN, u'NOT_SET': LOGIN_STATUS.NOT_SET, u'LOGIN_REJECTED_ILLEGAL_CHARACTERS': LOGIN_STATUS.LOGIN_REJECTED_ILLEGAL_CHARACTERS, u'LOGIN_REJECTED_NO_BASEAPP_RESPONSE': LOGIN_STATUS.LOGIN_REJECTED_NO_BASEAPP_RESPONSE, u'CANCELLED': LOGIN_STATUS.CANCELLED, u'LOGIN_BAD_PROTOCOL_VERSION': LOGIN_STATUS.LOGIN_BAD_PROTOCOL_VERSION, u'LOGIN_REJECTED_DB_GENERAL_FAILURE': LOGIN_STATUS.LOGIN_REJECTED_DB_GENERAL_FAILURE, u'LOGGED_ON_OFFLINE': LOGIN_STATUS.LOGGED_ON_OFFLINE, u'LOGIN_REJECTED_LOGIN_QUEUE': LOGIN_STATUS.LOGIN_REJECTED_LOGIN_QUEUE, u'CONNECTION_FAILED': LOGIN_STATUS.CONNECTION_FAILED, u'LOGIN_REJECTED_BASEAPPMGR_TIMEOUT': LOGIN_STATUS.LOGIN_REJECTED_BASEAPPMGR_TIMEOUT, u'LAST_CLIENT_SIDE_VALUE': LOGIN_STATUS.LAST_CLIENT_SIDE_VALUE, u'LOGIN_REJECTED_NOT_REGISTERED': LOGIN_STATUS.LOGIN_REJECTED_NOT_REGISTERED, u'LOGIN_REJECTED_BAD_DIGEST': LOGIN_STATUS.LOGIN_REJECTED_BAD_DIGEST, u'LOGIN_CUSTOM_DEFINED_ERROR': LOGIN_STATUS.LOGIN_CUSTOM_DEFINED_ERROR, u'LOGIN_REJECTED_ACTIVATING': LOGIN_STATUS.LOGIN_REJECTED_ACTIVATING, u'LOGIN_REJECTED_NO_SUCH_USER': LOGIN_STATUS.LOGIN_REJECTED_NO_SUCH_USER, u'LOGIN_REJECTED_BASEAPP_TIMEOUT': LOGIN_STATUS.LOGIN_REJECTED_BASEAPP_TIMEOUT, u'LOGIN_REJECTED_AUTH_SERVICE_GENERAL_FAILURE': LOGIN_STATUS.LOGIN_REJECTED_AUTH_SERVICE_GENERAL_FAILURE, u'LOGIN_REJECTED_RATE_LIMITED': LOGIN_STATUS.LOGIN_REJECTED_RATE_LIMITED, u'LOGIN_REJECTED_USERS_LIMIT': LOGIN_STATUS.LOGIN_REJECTED_USERS_LIMIT, u'LOGIN_REJECTED_LOGINS_NOT_ALLOWED': LOGIN_STATUS.LOGIN_REJECTED_LOGINS_NOT_ALLOWED, u'LAST_SERVER_SIDE_VALUE': LOGIN_STATUS.LAST_SERVER_SIDE_VALUE, u'LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED': LOGIN_STATUS.LOGIN_REJECTED_REGISTRATION_NOT_CONFIRMED, u'LOGIN_REJECTED_IP_ADDRESS_BAN': LOGIN_STATUS.LOGIN_REJECTED_IP_ADDRESS_BAN, u'LOGIN_REJECTED_INACCESSIBLE_REALM': LOGIN_STATUS.LOGIN_REJECTED_INACCESSIBLE_REALM, u'LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED': LOGIN_STATUS.LOGIN_REJECTED_REGISTRATION_NOT_ALLOWED, u'LOGIN_MALFORMED_REQUEST': LOGIN_STATUS.LOGIN_MALFORMED_REQUEST, u'LOGIN_REJECTED_INVALID_PASSWORD': LOGIN_STATUS.LOGIN_REJECTED_INVALID_PASSWORD, u'ALREADY_ONLINE_LOCALLY': LOGIN_STATUS.ALREADY_ONLINE_LOCALLY, u'LOGIN_REJECTED_NO_LOGINAPP': LOGIN_STATUS.LOGIN_REJECTED_NO_LOGINAPP, u'LOGIN_REJECTED_SERVER_NOT_READY': LOGIN_STATUS.LOGIN_REJECTED_SERVER_NOT_READY, u'LOGIN_REJECTED_CELLAPP_OVERLOAD': LOGIN_STATUS.LOGIN_REJECTED_CELLAPP_OVERLOAD, u'LOGIN_REJECTED_CHALLENGE_ERROR': LOGIN_STATUS.LOGIN_REJECTED_CHALLENGE_ERROR, u'LOGIN_REJECTED_BAN': LOGIN_STATUS.LOGIN_REJECTED_BAN, u'PUBLIC_KEY_LOOKUP_FAILED': LOGIN_STATUS.PUBLIC_KEY_LOOKUP_FAILED, u'LOGIN_REJECTED_DBAPP_OVERLOAD': LOGIN_STATUS.LOGIN_REJECTED_DBAPP_OVERLOAD, u'LOGIN_REJECTED_UPDATER_NOT_READY': LOGIN_STATUS.LOGIN_REJECTED_UPDATER_NOT_READY}
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'LOGIN_STATUS'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(self, *args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


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


class Latency(Simple):
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
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Latency'
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


class LatencyInfo(Vector4Provider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'LatencyInfo'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	value = property(lambda self: None)


class LinearHomer(Motor):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'LinearHomer'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	acceleration = property(lambda self: None)
	align = property(lambda self: None)
	blendOutTime = property(lambda self: None)
	offsetProvider = property(lambda self: None)
	owner = property(lambda self: None)
	pitchRollBlendInTime = property(lambda self: None)
	proximity = property(lambda self: None)
	proximityCallback = property(lambda self: None)
	revDelay = property(lambda self: None)
	target = property(lambda self: None)
	up = property(lambda self: None)


class LookupTable(pybind11_object):
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
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	__pybind11_module_local_v5_msvc__ = PyCapsule()
	__qualname__ = 'LookupTable'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
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


class MatrixProviderLiaison(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MatrixProviderLiaison'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass

def MemoryCriticalEventReport(*args, **kwargs): pass
def MemoryReport(*args, **kwargs): pass

class Model(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattr__(self, *args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Model'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addMotor(self, *args, **kwargs): pass
	def alignTriangle(self, *args, **kwargs): pass
	attached = property(lambda self: None)
	bounds = property(lambda self: None)
	castsShadow = property(lambda self: None)
	def cue(self, *args, **kwargs): pass
	def delMotor(self, *args, **kwargs): pass
	def deprecatedGetAnimationClipResource(self, *args, **kwargs): pass
	forceReflect = property(lambda self: None)
	height = property(lambda self: None)
	inWorld = property(lambda self: None)
	independentLod = property(lambda self: None)
	matrix = property(lambda self: None)
	motors = property(lambda self: None)
	moveAttachments = property(lambda self: None)
	moveScale = property(lambda self: None)
	def node(self, *args, **kwargs): pass
	def origin(self, *args, **kwargs): pass
	position = property(lambda self: None)
	def reflectOffTriangle(self, *args, **kwargs): pass
	root = property(lambda self: None)
	def rotate(self, *args, **kwargs): pass
	sacle = property(lambda self: None)
	sources = property(lambda self: None)
	def straighten(self, *args, **kwargs): pass
	tossCallback = property(lambda self: None)
	unitRotation = property(lambda self: None)
	vel = property(lambda self: None)
	visible = property(lambda self: None)
	visibleAttachments = property(lambda self: None)
	visibleDrawPass = property(lambda self: None)
	wg_isPlayer = property(lambda self: None)
	worldTransform = property(lambda self: None)
	yaw = property(lambda self: None)
	def zoomExtents(self, *args, **kwargs): pass


class MouseEvent(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MouseEvent'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	cursorPosition = property(lambda self: None)
	dx = property(lambda self: None)
	dy = property(lambda self: None)
	dz = property(lambda self: None)


class MouseTargetingMatrix(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MouseTargetingMatrix'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def detach(self, *args, **kwargs): pass

def MouseTargettingMatrix(*args, **kwargs): pass
NOT_SET = LOGIN_STATUS.NOT_SET

class OnlyArtyAimingSystem(ArtyAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'OnlyArtyAimingSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	aimPoint = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	direction = property(lambda self: None)
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def getCamDist(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightFromPlane = property(lambda self: None)
	hitPoint = property(lambda self: None)
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def overrideCamDist(self, *args, **kwargs): pass
	planePosition = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def setMaxRadius(self, *args, **kwargs): pass
	def setYaw(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	def updateTargetPos(self, *args, **kwargs): pass


class OnlyArtyAimingSystemRemote(OnlyArtyAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'OnlyArtyAimingSystemRemote'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	aimPoint = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	direction = property(lambda self: None)
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def getCamDist(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightFromPlane = property(lambda self: None)
	hitPoint = property(lambda self: None)
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def overrideCamDist(self, *args, **kwargs): pass
	planePosition = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def setMaxRadius(self, *args, **kwargs): pass
	def setYaw(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	def updateTargetPos(self, *args, **kwargs): pass


class Orbitor(Motor):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Orbitor'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	distanceScaler = property(lambda self: None)
	endSpeed = property(lambda self: None)
	maxAccel = property(lambda self: None)
	maxSpeed = property(lambda self: None)
	owner = property(lambda self: None)
	proximity = property(lambda self: None)
	proximityCallback = property(lambda self: None)
	slowHeigth = property(lambda self: None)
	speed = property(lambda self: None)
	spinRadius = property(lambda self: None)
	startSpin = property(lambda self: None)
	target = property(lambda self: None)
	weightingFunction = property(lambda self: None)
	wobble = property(lambda self: None)
	wobbleFreq = property(lambda self: None)
	wobbleMax = property(lambda self: None)


class Oscillator(Motor):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Oscillator'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	amplitude = property(lambda self: None)
	def canSee(self, *args, **kwargs): pass
	offset = property(lambda self: None)
	owner = property(lambda self: None)
	period = property(lambda self: None)
	yaw = property(lambda self: None)


class Oscillator2(Oscillator):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Oscillator2'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	amplitude = property(lambda self: None)
	def canSee(self, *args, **kwargs): pass
	offset = property(lambda self: None)
	owner = property(lambda self: None)
	period = property(lambda self: None)
	yaw = property(lambda self: None)

PUBLIC_KEY_LOOKUP_FAILED = LOGIN_STATUS.PUBLIC_KEY_LOOKUP_FAILED

class PlayerAvatarFilter(PyFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PlayerAvatarFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def enableLagDetection(self, *args, **kwargs): pass
	def input(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	def output(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass


class PlayerMatrix(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PlayerMatrix'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class PolygonalAreaBorder(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PolygonalAreaBorder'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def getClosestPoint(self, *args, **kwargs): pass
	def setMaterialBoolParam(self, *args, **kwargs): pass
	def setMaterialFloatParam(self, *args, **kwargs): pass
	def setMaterialVector4Param(self, *args, **kwargs): pass
	def setVisibility(self, *args, **kwargs): pass


class ProjectileMotor(Motor):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ProjectileMotor'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	owner = property(lambda self: None)


class ProjectionAccess(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ProjectionAccess'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	farPlane = property(lambda self: None)
	fov = property(lambda self: None)
	nearPlane = property(lambda self: None)
	def rampFov(self, *args, **kwargs): pass


class Propellor(Motor):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Propellor'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	actualTurn = property(lambda self: None)
	maxThrust = property(lambda self: None)
	momentum = property(lambda self: None)
	owner = property(lambda self: None)
	throttle = property(lambda self: None)
	timeScale = property(lambda self: None)
	turnHalflife = property(lambda self: None)
	turnRate = property(lambda self: None)
	wheelPosition = property(lambda self: None)
	xDrag = property(lambda self: None)
	yDrag = property(lambda self: None)
	zDrag = property(lambda self: None)


class PyBallisticsSimulator(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyBallisticsSimulator'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addProjectile(self, *args, **kwargs): pass
	def explodeProjectile(self, *args, **kwargs): pass
	def hideProjectile(self, *args, **kwargs): pass
	def holdProjectile(self, *args, **kwargs): pass
	def setBallisticsAutoScale(self, *args, **kwargs): pass
	def setFixedBallisticsParams(self, *args, **kwargs): pass
	def setVariableBallisticsParams(self, *args, **kwargs): pass


class PyCamoHandler(PyMaterialHandler):
	def (self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyCamoHandler'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class PyCollisionAssemblerProduct(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyCollisionAssemblerProduct'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class PyCustomizationHelper(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyCustomizationHelper'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def getSelectionResult(self, *args, **kwargs): pass
	def highlightRegions(self, *args, **kwargs): pass
	def resetHighlighting(self, *args, **kwargs): pass
	def selectRegions(self, *args, **kwargs): pass
	def setDOFenabled(self, *args, **kwargs): pass
	def setDOFparams(self, *args, **kwargs): pass
	def setHighlightingEnabled(self, *args, **kwargs): pass
	def setMotionBlurAmount(self, *args, **kwargs): pass
	def setMotionBlurEnabled(self, *args, **kwargs): pass
	def setSelectingEnabled(self, *args, **kwargs): pass
	def setSelectingRegionEnabled(self, *args, **kwargs): pass
	def setSelectionCallback(self, *args, **kwargs): pass
	def setSelectionMode(self, *args, **kwargs): pass
	def setSuspended(self, *args, **kwargs): pass


class PyDirtHandler(PyMaterialHandler):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyDirtHandler'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class PyEntities(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __len__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyEntities'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def get(self, *args, **kwargs): pass
	def has_key(self, *args, **kwargs): pass
	def items(self, *args, **kwargs): pass
	def keys(self, *args, **kwargs): pass
	def values(self, *args, **kwargs): pass
	def valuesOfType(self, *args, **kwargs): pass


class PyUniversalEvent(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __iadd__(self, *args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __isub__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyUniversalEvent'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def clear(self, *args, **kwargs): pass


class PyEvent(PyUniversalEvent):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __iadd__(self, *args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	def __isub__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyEvent'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def clear(self, *args, **kwargs): pass


class PyExtrapolationData(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyExtrapolationData'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	accumAngularAcceleration = property(lambda self: None)
	accumAngularVelocity = property(lambda self: None)
	accumLinearAcceleration = property(lambda self: None)
	accumLinearVelocity = property(lambda self: None)


class PyGammaWizard(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyGammaWizard'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	enable = property(lambda self: None)
	gamma = property(lambda self: None)
	offsetSize = property(lambda self: None)


class PyGlooxTag(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyGlooxTag'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def filterXPath(self, *args, **kwargs): pass
	def findAttribute(self, *args, **kwargs): pass
	def getCData(self, *args, **kwargs): pass
	def getTagName(self, *args, **kwargs): pass
	def getXml(self, *args, **kwargs): pass
	def setXml(self, *args, **kwargs): pass


class PyGroundEffectManager(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyGroundEffectManager'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def loadAirstrike(self, *args, **kwargs): pass
	def loadArtillery(self, *args, **kwargs): pass
	def playAirstrike(self, *args, **kwargs): pass
	def stopAll(self, *args, **kwargs): pass


class PyMaterialFashion(PyFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyMaterialFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class PyModelNode(MatrixProviderLiaison):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyModelNode'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def attach(self, *args, **kwargs): pass
	attachments = property(lambda self: None)
	def detach(self, *args, **kwargs): pass
	inWorld = property(lambda self: None)
	initialLocalMatrix = property(lambda self: None)
	local = property(lambda self: None)
	name = property(lambda self: None)


class PyOmniLight(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyOmniLight'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	bounds = property(lambda self: None)
	castShadows = property(lambda self: None)
	colorAnimator = property(lambda self: None)
	colour = property(lambda self: None)
	def destroyLight(self, *args, **kwargs): pass
	innerRadius = property(lambda self: None)
	multiplier = property(lambda self: None)
	multiplierAnimator = property(lambda self: None)
	offset = property(lambda self: None)
	outerRadius = property(lambda self: None)
	position = property(lambda self: None)
	source = property(lambda self: None)


class PyOutputStream(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyOutputStream'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def flush(self, *args, **kwargs): pass
	softspace = property(lambda self: None)
	def write(self, *args, **kwargs): pass


class PySalvo(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PySalvo'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addProjectile(self, *args, **kwargs): pass
	def startGenerator(self, *args, **kwargs): pass
	def stopGenerator(self, *args, **kwargs): pass


class PyScreener(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyScreener'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def setEnabled(self, *args, **kwargs): pass
	def setSettings(self, *args, **kwargs): pass
	def setUserId(self, *args, **kwargs): pass


class PySplodge(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PySplodge'
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
	maxLod = property(lambda self: None)


class PySpotLight(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PySpotLight'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	bounds = property(lambda self: None)
	castShadows = property(lambda self: None)
	colour = property(lambda self: None)
	coneAngle = property(lambda self: None)
	def destroyLight(self, *args, **kwargs): pass
	direction = property(lambda self: None)
	innerRadius = property(lambda self: None)
	multiplier = property(lambda self: None)
	outerRadius = property(lambda self: None)
	position = property(lambda self: None)
	source = property(lambda self: None)


class PyStrictPixelQuad(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyStrictPixelQuad'
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
	def setup(self, *args, **kwargs): pass


class PyTarget(pybind11_object):
	def __call__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyTarget'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def caps(self, *args, **kwargs): pass
	def clear(self, *args, **kwargs): pass
	def debugLock(self, *args, **kwargs): pass
	deselectionFovDegrees = property(lambda self: None)
	entity = property(lambda self: None)
	exclude = property(lambda self: None)
	isEnabled = property(lambda self: None)
	isFull = property(lambda self: None)
	isHeld = property(lambda self: None)
	isHidden = property(lambda self: None)
	maxDistance = property(lambda self: None)
	noPartial = property(lambda self: None)
	selectionFovDegrees = property(lambda self: None)
	skeletonCheckEnabled = property(lambda self: None)
	source = property(lambda self: None)


class PyTerrainSelectedArea(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyTerrainSelectedArea'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	attached = property(lambda self: None)
	castsShadow = property(lambda self: None)
	def enableAccurateCollision(self, *args, **kwargs): pass
	def enableWaterCollision(self, *args, **kwargs): pass
	def enableYCutOff(self, *args, **kwargs): pass
	inWorld = property(lambda self: None)
	def matchTerrain(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	def setColor(self, *args, **kwargs): pass
	def setCutOffAngle(self, *args, **kwargs): pass
	def setCutOffDistance(self, *args, **kwargs): pass
	def setLocalTransform(self, *args, **kwargs): pass
	def setMaxHeight(self, *args, **kwargs): pass
	def setMinHeight(self, *args, **kwargs): pass
	def setOverTerrainOffset(self, *args, **kwargs): pass
	def setParent(self, *args, **kwargs): pass
	def setSize(self, *args, **kwargs): pass
	def setUVAnimationType(self, *args, **kwargs): pass
	def setup(self, *args, **kwargs): pass
	def updateHeights(self, *args, **kwargs): pass


class PyTextureProvider(ITextureProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyTextureProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	height = property(lambda self: None)
	name = property(lambda self: None)
	owner = property(lambda self: None)
	width = property(lambda self: None)


class PyTimedWarplaneMotor(Motor):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyTimedWarplaneMotor'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addTrajectoryPoint(self, *args, **kwargs): pass
	def getMatrix(self, *args, **kwargs): pass
	owner = property(lambda self: None)
	def tick(self, *args, **kwargs): pass


class PyTrackScroll(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyTrackScroll'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def activate(self, *args, **kwargs): pass
	def deactivate(self, *args, **kwargs): pass
	def hasContact(self, *args, **kwargs): pass
	def leftContact(self, *args, **kwargs): pass
	def leftScroll(self, *args, **kwargs): pass
	def leftSlip(self, *args, **kwargs): pass
	def rightContact(self, *args, **kwargs): pass
	def rightScroll(self, *args, **kwargs): pass
	def rightSlip(self, *args, **kwargs): pass
	def setData(self, *args, **kwargs): pass
	def setExternal(self, *args, **kwargs): pass
	def setFlyingInfo(self, *args, **kwargs): pass
	def setMode(self, *args, **kwargs): pass


class PyTransformFashion(PyFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyTransformFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class PyURLResponse(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyURLResponse'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	body = property(lambda self: None)
	contentType = property(lambda self: None)
	def headers(self, *args, **kwargs): pass
	responseCode = property(lambda self: None)


class PyVOIP(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyVOIP'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def command(self, *args, **kwargs): pass
	def disableMicrophone(self, *args, **kwargs): pass
	def enableMicrophone(self, *args, **kwargs): pass
	def finalise(self, *args, **kwargs): pass
	def getAPI(self, *args, **kwargs): pass
	def getCaptureDevices(self, *args, **kwargs): pass
	def initialise(self, *args, **kwargs): pass
	def joinChannel(self, *args, **kwargs): pass
	def leaveChannel(self, *args, **kwargs): pass
	def login(self, *args, **kwargs): pass
	def logout(self, *args, **kwargs): pass
	def setCaptureDevice(self, *args, **kwargs): pass
	def setHandler(self, *args, **kwargs): pass
	def setMasterVolume(self, *args, **kwargs): pass
	def setMicrophoneVolume(self, *args, **kwargs): pass


class PyWgArtilleryCalculator(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyWgArtilleryCalculator'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def computeArtilleryImpactArea(self, *args, **kwargs): pass
	epsilon = property(lambda self: None)
	gravity = property(lambda self: None)
	maxTime = property(lambda self: None)
	tickLength = property(lambda self: None)

R16F = ResourceFormat.R16F
R32F = ResourceFormat.R32F
R5G6B5 = ResourceFormat.R5G6B5
R8G8B8 = ResourceFormat.R8G8B8

class ReplayTerminatedReason(pybind11_object):
	REPLAY_ABORTED_CORRUPTED_DATA = ReplayTerminatedReason.REPLAY_ABORTED_CORRUPTED_DATA
	REPLAY_ABORTED_ENTITYDEF_MISMATCH = ReplayTerminatedReason.REPLAY_ABORTED_ENTITYDEF_MISMATCH
	REPLAY_ABORTED_METADATA_REJECTED = ReplayTerminatedReason.REPLAY_ABORTED_METADATA_REJECTED
	REPLAY_ABORTED_VERSION_MISMATCH = ReplayTerminatedReason.REPLAY_ABORTED_VERSION_MISMATCH
	REPLAY_STOPPED_PLAYBACK = ReplayTerminatedReason.REPLAY_STOPPED_PLAYBACK
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  REPLAY_ABORTED_METADATA_REJECTED\n\n  REPLAY_ABORTED_ENTITYDEF_MISMATCH\n\n  REPLAY_STOPPED_PLAYBACK\n\n  REPLAY_ABORTED_VERSION_MISMATCH\n\n  REPLAY_ABORTED_CORRUPTED_DATA'
	__entries = {u'REPLAY_ABORTED_METADATA_REJECTED': (ReplayTerminatedReason.REPLAY_ABORTED_METADATA_REJECTED, None), u'REPLAY_ABORTED_ENTITYDEF_MISMATCH': (ReplayTerminatedReason.REPLAY_ABORTED_ENTITYDEF_MISMATCH, None), u'REPLAY_STOPPED_PLAYBACK': (ReplayTerminatedReason.REPLAY_STOPPED_PLAYBACK, None), u'REPLAY_ABORTED_VERSION_MISMATCH': (ReplayTerminatedReason.REPLAY_ABORTED_VERSION_MISMATCH, None), u'REPLAY_ABORTED_CORRUPTED_DATA': (ReplayTerminatedReason.REPLAY_ABORTED_CORRUPTED_DATA, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'REPLAY_ABORTED_METADATA_REJECTED': ReplayTerminatedReason.REPLAY_ABORTED_METADATA_REJECTED, u'REPLAY_ABORTED_VERSION_MISMATCH': ReplayTerminatedReason.REPLAY_ABORTED_VERSION_MISMATCH, u'REPLAY_STOPPED_PLAYBACK': ReplayTerminatedReason.REPLAY_STOPPED_PLAYBACK, u'REPLAY_ABORTED_ENTITYDEF_MISMATCH': ReplayTerminatedReason.REPLAY_ABORTED_ENTITYDEF_MISMATCH, u'REPLAY_ABORTED_CORRUPTED_DATA': ReplayTerminatedReason.REPLAY_ABORTED_CORRUPTED_DATA}
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ReplayTerminatedReason'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


class ResourceFormat(pybind11_object):
	A16B16G16R16 = ResourceFormat.A16B16G16R16
	A16B16G16R16F = ResourceFormat.A16B16G16R16F
	A1R5G5B5 = ResourceFormat.A1R5G5B5
	A2B10G10R10 = ResourceFormat.A2B10G10R10
	A32B32G32R32F = ResourceFormat.A32B32G32R32F
	A8 = ResourceFormat.A8
	A8B8G8R8 = ResourceFormat.A8B8G8R8
	A8L8 = ResourceFormat.A8L8
	A8R8G8B8 = ResourceFormat.A8R8G8B8
	D15S1 = ResourceFormat.D15S1
	D16 = ResourceFormat.D16
	D16_LOCKABLE = ResourceFormat.D16_LOCKABLE
	D24S8 = ResourceFormat.D24S8
	D24X4S4 = ResourceFormat.D24X4S4
	D24X8 = ResourceFormat.D24X8
	D32 = ResourceFormat.D32
	D32F_LOCKABLE = ResourceFormat.D32F_LOCKABLE
	DXT1 = ResourceFormat.DXT1
	DXT2 = ResourceFormat.DXT2
	DXT3 = ResourceFormat.DXT3
	DXT4 = ResourceFormat.DXT4
	DXT5 = ResourceFormat.DXT5
	G16R16 = ResourceFormat.G16R16
	G16R16F = ResourceFormat.G16R16F
	G32R32F = ResourceFormat.G32R32F
	L16 = ResourceFormat.L16
	L8 = ResourceFormat.L8
	R16F = ResourceFormat.R16F
	R32F = ResourceFormat.R32F
	R5G6B5 = ResourceFormat.R5G6B5
	R8G8B8 = ResourceFormat.R8G8B8
	UNKNOWN = ResourceFormat.UNKNOWN
	X1R5G5B5 = ResourceFormat.X1R5G5B5
	X8B8G8R8 = ResourceFormat.X8B8G8R8
	X8R8G8B8 = ResourceFormat.X8R8G8B8
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  D16\n\n  R8G8B8\n\n  G32R32F\n\n  A16B16G16R16\n\n  DXT4\n\n  UNKNOWN\n\n  D32F_LOCKABLE\n\n  D15S1\n\n  D32\n\n  DXT1\n\n  A1R5G5B5\n\n  DXT3\n\n  X1R5G5B5\n\n  DXT2\n\n  D24S8\n\n  G16R16F\n\n  A8B8G8R8\n\n  L8\n\n  G16R16\n\n  A32B32G32R32F\n\n  A2B10G10R10\n\n  L16\n\n  R5G6B5\n\n  D24X8\n\n  D24X4S4\n\n  X8B8G8R8\n\n  D16_LOCKABLE\n\n  A8L8\n\n  R32F\n\n  R16F\n\n  DXT5\n\n  A8\n\n  A8R8G8B8\n\n  X8R8G8B8\n\n  A16B16G16R16F'
	__entries = {u'D16': (ResourceFormat.D16, None), u'R8G8B8': (ResourceFormat.R8G8B8, None), u'G32R32F': (ResourceFormat.G32R32F, None), u'A16B16G16R16': (ResourceFormat.A16B16G16R16, None), u'DXT4': (ResourceFormat.DXT4, None), u'UNKNOWN': (ResourceFormat.UNKNOWN, None), u'D32F_LOCKABLE': (ResourceFormat.D32F_LOCKABLE, None), u'D15S1': (ResourceFormat.D15S1, None), u'D32': (ResourceFormat.D32, None), u'DXT1': (ResourceFormat.DXT1, None), u'A1R5G5B5': (ResourceFormat.A1R5G5B5, None), u'DXT3': (ResourceFormat.DXT3, None), u'X1R5G5B5': (ResourceFormat.X1R5G5B5, None), u'DXT2': (ResourceFormat.DXT2, None), u'D24S8': (ResourceFormat.D24S8, None), u'G16R16F': (ResourceFormat.G16R16F, None), u'A8B8G8R8': (ResourceFormat.A8B8G8R8, None), u'L8': (ResourceFormat.L8, None), u'G16R16': (ResourceFormat.G16R16, None), u'A32B32G32R32F': (ResourceFormat.A32B32G32R32F, None), u'A2B10G10R10': (ResourceFormat.A2B10G10R10, None), u'L16': (ResourceFormat.L16, None), u'R5G6B5': (ResourceFormat.R5G6B5, None), u'D24X8': (ResourceFormat.D24X8, None), u'D24X4S4': (ResourceFormat.D24X4S4, None), u'X8B8G8R8': (ResourceFormat.X8B8G8R8, None), u'D16_LOCKABLE': (ResourceFormat.D16_LOCKABLE, None), u'A8L8': (ResourceFormat.A8L8, None), u'R32F': (ResourceFormat.R32F, None), u'R16F': (ResourceFormat.R16F, None), u'DXT5': (ResourceFormat.DXT5, None), u'A8': (ResourceFormat.A8, None), u'A8R8G8B8': (ResourceFormat.A8R8G8B8, None), u'X8R8G8B8': (ResourceFormat.X8R8G8B8, None), u'A16B16G16R16F': (ResourceFormat.A16B16G16R16F, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'D16': ResourceFormat.D16, u'R8G8B8': ResourceFormat.R8G8B8, u'A16B16G16R16': ResourceFormat.A16B16G16R16, u'DXT4': ResourceFormat.DXT4, u'UNKNOWN': ResourceFormat.UNKNOWN, u'D32F_LOCKABLE': ResourceFormat.D32F_LOCKABLE, u'D15S1': ResourceFormat.D15S1, u'D32': ResourceFormat.D32, u'DXT1': ResourceFormat.DXT1, u'A1R5G5B5': ResourceFormat.A1R5G5B5, u'DXT3': ResourceFormat.DXT3, u'X1R5G5B5': ResourceFormat.X1R5G5B5, u'DXT2': ResourceFormat.DXT2, u'D24S8': ResourceFormat.D24S8, u'A8R8G8B8': ResourceFormat.A8R8G8B8, u'L8': ResourceFormat.L8, u'G16R16': ResourceFormat.G16R16, u'DXT5': ResourceFormat.DXT5, u'A32B32G32R32F': ResourceFormat.A32B32G32R32F, u'R16F': ResourceFormat.R16F, u'A2B10G10R10': ResourceFormat.A2B10G10R10, u'L16': ResourceFormat.L16, u'D16_LOCKABLE': ResourceFormat.D16_LOCKABLE, u'D24X8': ResourceFormat.D24X8, u'D24X4S4': ResourceFormat.D24X4S4, u'X8R8G8B8': ResourceFormat.X8R8G8B8, u'R5G6B5': ResourceFormat.R5G6B5, u'A8L8': ResourceFormat.A8L8, u'R32F': ResourceFormat.R32F, u'G32R32F': ResourceFormat.G32R32F, u'G16R16F': ResourceFormat.G16R16F, u'A8': ResourceFormat.A8, u'A8B8G8R8': ResourceFormat.A8B8G8R8, u'X8B8G8R8': ResourceFormat.X8B8G8R8, u'A16B16G16R16F': ResourceFormat.A16B16G16R16F}
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ResourceFormat'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


class ResourceRefs(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __len__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ResourceRefs'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	failedIDs = property(lambda self: None)
	def has_key(self, *args, **kwargs): pass
	def items(self, *args, **kwargs): pass
	def keys(self, *args, **kwargs): pass
	def pop(self, *args, **kwargs): pass
	def values(self, *args, **kwargs): pass


class RouteTransitionCamera(CollidableTransitionCamera):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'RouteTransitionCamera'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	direction = property(lambda self: None)
	def finish(self, *args, **kwargs): pass
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	def isInTransition(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	position = property(lambda self: None)
	def positionEasingProgress(self, *args, **kwargs): pass
	def render(self, *args, **kwargs): pass
	def rotationEasingProgress(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)
	def start(self, *args, **kwargs): pass
	def startAlongRoute(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass

SLERP_OF_CARTESIAN = FilterInterpolationType.SLERP_OF_CARTESIAN
SPHERICAL_RADIANS = FilterInterpolationType.SPHERICAL_RADIANS
STAGE_DATA = 2
STAGE_DISCONNECTED = 6
STAGE_INITIAL = 0
STAGE_LOGIN = 1

class ScanDirProvider(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ScanDirProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	amplitude = property(lambda self: None)
	offset = property(lambda self: None)
	period = property(lambda self: None)

Screener = PyScreener()

class SequenceTransitionCamera(BaseCamera):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SequenceTransitionCamera'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	direction = property(lambda self: None)
	def finish(self, *args, **kwargs): pass
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	def isInTransition(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	position = property(lambda self: None)
	def render(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)
	def start(self, *args, **kwargs): pass
	def unbind(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass


class Server(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__members__ = property(lambda self: None)
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Server'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class ServerCaller(pybind11_object):
	def __call__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ServerCaller'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class ServerDiscovery(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ServerDiscovery'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	changeNotifier = property(lambda self: None)
	searching = property(lambda self: None)
	servers = property(lambda self: None)


class Servo(Motor):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Servo'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	owner = property(lambda self: None)
	signal = property(lambda self: None)

def SetDrawInflux(*args, **kwargs): pass
ShadowPassBit = 2

class SkeletonCollider(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SkeletonCollider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addCollider(self, *args, **kwargs): pass
	def doCollide(self, *args, **kwargs): pass
	def getCollider(self, *args, **kwargs): pass
	impactCollider = property(lambda self: None)
	impactPoint = property(lambda self: None)
	impactReflection = property(lambda self: None)
	def load(self, *args, **kwargs): pass
	def nColliders(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass


class SniperAimingSystem(IAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SniperAimingSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def enableAutoRotation(self, *args, **kwargs): pass
	def enableHorizontalStabilizerRuntime(self, *args, **kwargs): pass
	def focusOnPos(self, *args, **kwargs): pass
	def forceFullStabilization(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getDynamicPitchLimits(self, *args, **kwargs): pass
	def getHullLockSetting(*args, **kwargs): pass
	def getPitchLimits(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getStabilizerSettings(*args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	gunPitch = property(lambda self: None)
	def handleMovement(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def onSiegeStateChanged(self, *args, **kwargs): pass
	def overrideZoom(self, *args, **kwargs): pass
	def resetIdealDirection(self, *args, **kwargs): pass
	def setAimingLimits(self, *args, **kwargs): pass
	def setHullLockSetting(*args, **kwargs): pass
	def setStabilizerSettings(*args, **kwargs): pass
	turretYaw = property(lambda self: None)
	def update(self, *args, **kwargs): pass


class SniperAimingSystemRemote(SniperAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SniperAimingSystemRemote'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def enableAutoRotation(self, *args, **kwargs): pass
	def enableHorizontalStabilizerRuntime(self, *args, **kwargs): pass
	def focusOnPos(self, *args, **kwargs): pass
	def forceFullStabilization(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getDynamicPitchLimits(self, *args, **kwargs): pass
	def getHullLockSetting(*args, **kwargs): pass
	def getPitchLimits(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getStabilizerSettings(*args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	gunPitch = property(lambda self: None)
	def handleMovement(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def onSiegeStateChanged(self, *args, **kwargs): pass
	def overrideZoom(self, *args, **kwargs): pass
	def resetIdealDirection(self, *args, **kwargs): pass
	def setAimingLimits(self, *args, **kwargs): pass
	def setHullLockSetting(*args, **kwargs): pass
	def setStabilizerSettings(*args, **kwargs): pass
	turretYaw = property(lambda self: None)
	def update(self, *args, **kwargs): pass


class Space(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Space'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	id = property(lambda self: None)


class SpaceIDList(pybind11_object):
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
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	__pybind11_module_local_v5_msvc__ = PyCapsule()
	__qualname__ = 'SpaceIDList'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
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


class SpacePtrList(pybind11_object):
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
	__module__ = 'BigWorld'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	__pybind11_module_local_v5_msvc__ = PyCapsule()
	__qualname__ = 'SpacePtrList'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
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


class SpacesMap(pybind11_object):
	def __contains__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	def __delitem__(self, *args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __iter__(self, *args, **kwargs): pass
	def __len__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	def __nonzero__(self, *args, **kwargs): pass
	__pybind11_module_local_v5_msvc__ = PyCapsule()
	__qualname__ = 'SpacesMap'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setitem__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def items(self, *args, **kwargs): pass


class SphericalTransitionCamera(CursorCamera):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SphericalTransitionCamera'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addVolumeGroup(self, *args, **kwargs): pass
	direction = property(lambda self: None)
	def enableAdvancedCollider(self, *args, **kwargs): pass
	def forceUpdate(self, *args, **kwargs): pass
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	isHangar = property(lambda self: None)
	def isInTransition(self, *args, **kwargs): pass
	isMovementEnabled = property(lambda self: None)
	matrix = property(lambda self: None)
	maxDistHalfLife = property(lambda self: None)
	def moveTo(self, *args, **kwargs): pass
	movementHalfLife = property(lambda self: None)
	movementHalfLifeMultiplier = property(lambda self: None)
	movementMode = property(lambda self: None)
	pivotMaxDist = property(lambda self: None)
	pivotMinDist = property(lambda self: None)
	pivotPosition = property(lambda self: None)
	position = property(lambda self: None)
	def render(self, *args, **kwargs): pass
	reverseView = property(lambda self: None)
	def set(self, *args, **kwargs): pass
	def setDynamicCollisions(self, *args, **kwargs): pass
	source = property(lambda self: None)
	spaceID = property(lambda self: None)
	def stop(self, *args, **kwargs): pass
	target = property(lambda self: None)
	targetMaxDist = property(lambda self: None)
	targetPivotPosition = property(lambda self: None)
	terrainMinDist = property(lambda self: None)
	turningHalfLife = property(lambda self: None)
	def update(self, *args, **kwargs): pass
	uprightDirection = property(lambda self: None)

def Splodge(*args, **kwargs): pass

class PyStaticComponent(PyObjectPlus):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__members__ = property(lambda self: None)
	__methods__ = property(lambda self: None)
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	entity = property(lambda self: None)
	isActive = property(lambda self: None)


class StaticScriptComponent(PyStaticComponent):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__members__ = property(lambda self: None)
	__methods__ = property(lambda self: None)
	def __new__(*args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	base = property(lambda self: None)
	cell = property(lambda self: None)
	entity = property(lambda self: None)
	isActive = property(lambda self: None)


class StrategicAimingSystem(BaseStrategicAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'StrategicAimingSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	def clampAimingRadius(self, *args, **kwargs): pass
	def destroy(self, *args, **kwargs): pass
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def getCamDist(self, *args, **kwargs): pass
	def getCamYaw(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightFromPlane = property(lambda self: None)
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def overrideCamDist(self, *args, **kwargs): pass
	planePosition = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def setParallaxModeEnabled(self, *args, **kwargs): pass
	def setYaw(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	def updateTargetPos(self, *args, **kwargs): pass
	def updateYaw(self, *args, **kwargs): pass


class StrategicAimingSystemRemote(StrategicAimingSystem):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'StrategicAimingSystemRemote'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	aimMatrix = property(lambda self: None)
	def clampAimingRadius(self, *args, **kwargs): pass
	def destroy(self, *args, **kwargs): pass
	def disable(self, *args, **kwargs): pass
	def enable(self, *args, **kwargs): pass
	def getCamDist(self, *args, **kwargs): pass
	def getCamYaw(self, *args, **kwargs): pass
	def getDesiredShotPoint(self, *args, **kwargs): pass
	def getShotPoint(self, *args, **kwargs): pass
	def getZoom(self, *args, **kwargs): pass
	def handleMovement(self, *args, **kwargs): pass
	height = property(lambda self: None)
	heightFromPlane = property(lambda self: None)
	matrix = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	def overrideCamDist(self, *args, **kwargs): pass
	planePosition = property(lambda self: None)
	def setAimingLimits(self, *args, **kwargs): pass
	def setParallaxModeEnabled(self, *args, **kwargs): pass
	def setYaw(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	def updateTargetPos(self, *args, **kwargs): pass
	def updateYaw(self, *args, **kwargs): pass


class Targeting(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Targeting'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	autoAim = property(lambda self: None)
	autoAimOn = property(lambda self: None)
	defaultDeselectionAngle = property(lambda self: None)
	defaultSelectionAngle = property(lambda self: None)
	defaultSelectionDistance = property(lambda self: None)
	deselectionAngle = property(lambda self: None)
	selectionAngle = property(lambda self: None)
	selectionDistance = property(lambda self: None)


class ThirdPersonProvider(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ThirdPersonProvider'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addVolumeGroup(self, *args, **kwargs): pass
	base = property(lambda self: None)
	distanceFromFocus = property(lambda self: None)
	focusRadius = property(lambda self: None)
	heightAboveBase = property(lambda self: None)
	idealMatrix = property(lambda self: None)
	def initAdvancedCollider(self, *args, **kwargs): pass
	def lookAt(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	pitch = property(lambda self: None)
	positionAboveBaseProvider = property(lambda self: None)
	def setDynamicCollisions(self, *args, **kwargs): pass
	up = property(lambda self: None)
	def update(self, *args, **kwargs): pass
	yaw = property(lambda self: None)


class ThirdPersonTargetingMatrix(MatrixProvider):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ThirdPersonTargetingMatrix'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	source = property(lambda self: None)

def ThirdPersonTargettingMatrix(*args, **kwargs): pass

class TrajectoryDrawer(PyComponentWrapperBase):
	def __cmp__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'TrajectoryDrawer'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addProjectile(self, *args, **kwargs): pass
	def clear(self, *args, **kwargs): pass
	def destroy(self, *args, **kwargs): pass
	def id(self, *args, **kwargs): pass
	def removeProjectile(self, *args, **kwargs): pass
	def valid(self, *args, **kwargs): pass


class TransitionCamera(BaseCamera):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'TransitionCamera'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	direction = property(lambda self: None)
	def finish(self, *args, **kwargs): pass
	def handleAxisEvent(self, *args, **kwargs): pass
	def handleKeyEvent(self, *args, **kwargs): pass
	def handleMouseEvent(self, *args, **kwargs): pass
	invViewMatrix = property(lambda self: None)
	def isInTransition(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	position = property(lambda self: None)
	def render(self, *args, **kwargs): pass
	def set(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)
	def start(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass

UNKNOWN = ResourceFormat.UNKNOWN
UNKNOWN_ERROR = LOGIN_STATUS.UNKNOWN_ERROR

class UnresolvedUDORefException(Exception):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(*args, **kwargs): pass
	def __getslice__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
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
	message = property(lambda self: None)


class UserDataObject(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'UserDataObject'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	direction = property(lambda self: None)
	guid = property(lambda self: None)
	pitch = property(lambda self: None)
	position = property(lambda self: None)
	roll = property(lambda self: None)
	yaw = property(lambda self: None)

VIEW_CREATED = EventType.VIEW_CREATED
VIEW_DESTROYED = EventType.VIEW_DESTROYED
VIEW_LOADED = EventType.VIEW_LOADED
VOIP = PyVOIP()

class WGActionCurve(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGActionCurve'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def getChannelProperty(self, *args, **kwargs): pass
	def getChannelsCount(self, *args, **kwargs): pass


class WGAlphaFadeCompoundFashion(ICompoundFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGAlphaFadeCompoundFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	maxAlphaDist = property(lambda self: None)
	minAlpha = property(lambda self: None)


class WGAlphaFadeFashion(PyMaterialFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGAlphaFadeFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def maxAlphaDist(self, *args, **kwargs): pass
	def minAlpha(self, *args, **kwargs): pass


class WGBaseFashion(ICompoundFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGBaseFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addMaterialHandler(self, *args, **kwargs): pass
	def addTrackMaterialHandler(self, *args, **kwargs): pass
	def changeMaterialsVisibility(self, *args, **kwargs): pass
	def disowned(self, *args, **kwargs): pass
	def getMaterialHandlers(self, *args, **kwargs): pass
	def getTrackMaterialHandlers(self, *args, **kwargs): pass
	def removeCamouflage(self, *args, **kwargs): pass
	def setCamouflage(self, *args, **kwargs): pass


class WGEntityFilter(PyFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGEntityFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	allowCustomResets = True
	allowLagCollisions = True
	canExtrapolateOnLag = True
	defaultMaxTimeBetweenInputs = 2.0
	enableClientFilters = True
	def enableLagDetection(self, *args, **kwargs): pass
	ignoreInputs = property(lambda self: None)
	ignoreNextReset = property(lambda self: None)
	def input(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	latestInput = property(lambda self: None)
	maxMove = property(lambda self: None)
	maxTimeBetweenInputs = property(lambda self: None)
	movementExtrapolationData = property(lambda self: None)
	def output(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass
	def segmentMayHitEntity(self, *args, **kwargs): pass
	def setScriptInputCallback(self, *args, **kwargs): pass
	def transferInput(self, *args, **kwargs): pass
	def transferInputAsVehicle(self, *args, **kwargs): pass


class WGFlagAlphaFadeFashion(ICompoundFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGFlagAlphaFadeFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	maxAlphaDist = property(lambda self: None)
	minAlpha = property(lambda self: None)
	def overridePosition(self, *args, **kwargs): pass
	def setColor(self, *args, **kwargs): pass
	def setEmblemTexture(self, *args, **kwargs): pass
	def setFlagBackgroundTexture(self, *args, **kwargs): pass


class WGFlockManager(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGFlockManager'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addActivationPoint(self, *args, **kwargs): pass
	def addFlock(self, *args, **kwargs): pass
	onTriggerCallback = property(lambda self: None)
	def start(self, *args, **kwargs): pass
	def stop(self, *args, **kwargs): pass
	def vehicleEnter(self, *args, **kwargs): pass
	def vehicleLeave(self, *args, **kwargs): pass


class WGGunRotatorImpl(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGGunRotatorImpl'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	absoluteGunPitchLimits = property(lambda self: None)
	autorotationFlags = property(lambda self: None)
	compensationSpeedup = property(lambda self: None)
	enablePitchSpeedAdjustment = property(lambda self: None)
	exportPitchOrigin = property(lambda self: None)
	exportYawOrigin = property(lambda self: None)
	fixGunPitch = property(lambda self: None)
	fixTurretYaw = property(lambda self: None)
	gotTargetPoint = property(lambda self: None)
	gotTurretYawLimits = property(lambda self: None)
	gravity = property(lambda self: None)
	gunAnglesEncoded = property(lambda self: None)
	gunPitch = property(lambda self: None)
	gunPositionLocal = property(lambda self: None)
	gunRotationSpeed = property(lambda self: None)
	hullPitchCorrection = property(lambda self: None)
	hullPitchCorrectionToApply = property(lambda self: None)
	hullPitchFlexible = property(lambda self: None)
	hullPitchRequired = property(lambda self: None)
	isAutorotationModeChanged = property(lambda self: None)
	isDispersionChanged = property(lambda self: None)
	isFixed = property(lambda self: None)
	isGunMoved = property(lambda self: None)
	isLocked = property(lambda self: None)
	lockedGunRotationSpeed = property(lambda self: None)
	pitchOrigin = property(lambda self: None)
	projectileSpeed = property(lambda self: None)
	shotDirection = property(lambda self: None)
	shotDispersion = property(lambda self: None)
	shotDispersionFactor = property(lambda self: None)
	shotPoint = property(lambda self: None)
	targetPoint = property(lambda self: None)
	turretLastRotationSpeed = property(lambda self: None)
	turretPositionLocal = property(lambda self: None)
	turretRotationSpeed = property(lambda self: None)
	turretYaw = property(lambda self: None)
	turretYawLimits = property(lambda self: None)
	def update(self, *args, **kwargs): pass
	useNewMethod = property(lambda self: None)
	useSteepAngles = property(lambda self: None)
	vehicleMatrix = property(lambda self: None)
	vehicleRotationSpeed = property(lambda self: None)
	yawDeltaFromOrigin = property(lambda self: None)
	yawOrigin = property(lambda self: None)


class WGMaterialDisabler(PyMaterialFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGMaterialDisabler'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def hasDamagedMaterial(self, *args, **kwargs): pass
	isDestroyed = property(lambda self: None)
	def setEnableDrawMergedModel(self, *args, **kwargs): pass
	def setMaterialKindVisible(self, *args, **kwargs): pass
	def setPyModel(self, *args, **kwargs): pass


class WGOcclusionDecal(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGOcclusionDecal'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	attached = property(lambda self: None)
	castsShadow = property(lambda self: None)
	def create(self, *args, **kwargs): pass
	inWorld = property(lambda self: None)
	matrix = property(lambda self: None)
	def setLocalTransform(self, *args, **kwargs): pass


class WGPhysicalBody(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGPhysicalBody'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addBoxShape(self, *args, **kwargs): pass
	def addShape(self, *args, **kwargs): pass
	angVelocity = property(lambda self: None)
	def applyImpulse(self, *args, **kwargs): pass
	boundingRadius = property(lambda self: None)
	def collideSegment(self, *args, **kwargs): pass
	def destructibleImpactCb(self, *args, **kwargs): pass
	def destructibleRequestCb(self, *args, **kwargs): pass
	externalForce = property(lambda self: None)
	forceApplied = property(lambda self: None)
	freezeAccelEpsilon = property(lambda self: None)
	freezeAngAccelEpsilon = property(lambda self: None)
	freezeAngVelEpsilon = property(lambda self: None)
	freezePosErrorEpsilon = property(lambda self: None)
	freezeVelEpsilon = property(lambda self: None)
	def getProjectionArea(self, *args, **kwargs): pass
	gravity = property(lambda self: None)
	hydroResistanceFactor = property(lambda self: None)
	hydroResistanceRotFactor = property(lambda self: None)
	isCollidingWithWorld = property(lambda self: None)
	isCwwThresholdFactor = property(lambda self: None)
	isFrozen = property(lambda self: None)
	isUnderWater = property(lambda self: None)
	mass = property(lambda self: None)
	owner = property(lambda self: None)
	def removeShapes(self, *args, **kwargs): pass
	def setCoreSegment(self, *args, **kwargs): pass
	def setup(self, *args, **kwargs): pass
	staticCollisionEnergy = property(lambda self: None)
	staticCollisionNormal = property(lambda self: None)
	staticCollisionPoint = property(lambda self: None)
	staticCollisionReaction = property(lambda self: None)
	staticCollisionSelfPoint = property(lambda self: None)
	staticMode = property(lambda self: None)
	staticSceneFriction = property(lambda self: None)
	torqueApplied = property(lambda self: None)
	velocity = property(lambda self: None)


class WGPillboxFilter(WGEntityFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGPillboxFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	allowCustomResets = True
	allowLagCollisions = True
	canExtrapolateOnLag = True
	defaultMaxTimeBetweenInputs = 2.0
	enableClientFilters = True
	def enableLagDetection(self, *args, **kwargs): pass
	def enableStabilisedMatrix(self, *args, **kwargs): pass
	gunMatrix = property(lambda self: None)
	ignoreInputs = property(lambda self: None)
	ignoreNextReset = property(lambda self: None)
	def input(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	latestInput = property(lambda self: None)
	maxMove = property(lambda self: None)
	maxTimeBetweenInputs = property(lambda self: None)
	movementExtrapolationData = property(lambda self: None)
	def output(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass
	def segmentMayHitEntity(self, *args, **kwargs): pass
	def setScriptInputCallback(self, *args, **kwargs): pass
	speedInfo = property(lambda self: None)
	def syncGunAngles(self, *args, **kwargs): pass
	def transferInput(self, *args, **kwargs): pass
	def transferInputAsVehicle(self, *args, **kwargs): pass
	turretMatrix = property(lambda self: None)
	# TypeError:
	# (): incompatible function arguments. The following argument types are supported:
	# 1. () -> Vector3
	# 
	# Invoked with: <class 'BigWorld.WGPillboxFilter'>
	velocity = None  # error description above


class WGPingerInstance(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGPingerInstance'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def clearOnPingCallback(self, *args, **kwargs): pass
	def ping(self, *args, **kwargs): pass
	def setOnPingCallback(self, *args, **kwargs): pass

WGPinger = WGPingerInstance()

class WGRenderSettings(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGRenderSettings'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def flashBangAnimation(self, *args, **kwargs): pass
	def getVignetteSettings(self, *args, **kwargs): pass
	def removeFlashBangAnimation(self, *args, **kwargs): pass
	def setVignetteSettings(self, *args, **kwargs): pass


class WGReplayController(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGReplayController'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	ammoButtonPressedCallback = property(lambda self: None)
	arenaLength = property(lambda self: None)
	arenaPeriod = property(lambda self: None)
	battleChatMessageCallback = property(lambda self: None)
	def beginTimeWarp(self, *args, **kwargs): pass
	clientVersion = property(lambda self: None)
	clientVersionDiffersCallback = property(lambda self: None)
	def confirmDlgAccepted(self, *args, **kwargs): pass
	controlMode = property(lambda self: None)
	controlModeChangedCallback = property(lambda self: None)
	dualAccDiameter = property(lambda self: None)
	entityAoIChangedCallback = property(lambda self: None)
	equipmentIdCallback = property(lambda self: None)
	fps = property(lambda self: None)
	def getAimClipPosition(self, *args, **kwargs): pass
	def getArcadeGunMarkerSize(self, *args, **kwargs): pass
	def getArenaInfoStr(self, *args, **kwargs): pass
	def getAutoStartFileName(*args, **kwargs): pass
	def getCallbackHandler(self, *args, **kwargs): pass
	def getConsumableSlotCooldownAmount(self, *args, **kwargs): pass
	def getDualAccMarkerSize(self, *args, **kwargs): pass
	def getGunReloadAmountLeft(self, *args, **kwargs): pass
	def getReplayEndTime(*args, **kwargs): pass
	def getReplayStartTime(*args, **kwargs): pass
	def getReplayTimes(*args, **kwargs): pass
	def getSPGGunMarkerParams(self, *args, **kwargs): pass
	def getTimeMark(self, *args, **kwargs): pass
	def getTurretYawByTime(self, *args, **kwargs): pass
	gunMarkerDiameter = property(lambda self: None)
	gunMarkerDirection = property(lambda self: None)
	gunMarkerPosition = property(lambda self: None)
	gunPitch = property(lambda self: None)
	gunRotatorTargetPoint = property(lambda self: None)
	hasMods = property(lambda self: None)
	isClientReady = property(lambda self: None)
	isControllingCamera = property(lambda self: None)
	def isEffectNeedToPlay(self, *args, **kwargs): pass
	def isFileCompressed(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	isOfflinePlaybackMode = property(lambda self: None)
	def isPlaying(self, *args, **kwargs): pass
	isRecording = property(lambda self: None)
	isServerAim = property(lambda self: None)
	isServerSideReplay = property(lambda self: None)
	isTimeWarpInProgress = property(lambda self: None)
	lockTargetCallback = property(lambda self: None)
	def onAmmoButtonPressed(self, *args, **kwargs): pass
	def onBattleChatMessage(self, *args, **kwargs): pass
	def onBattleLoadingFinished(self, *args, **kwargs): pass
	def onClientReady(self, *args, **kwargs): pass
	def onLockTarget(self, *args, **kwargs): pass
	def onMakeScreenshot(self, *args, **kwargs): pass
	def onPutScreenshotMark(self, *args, **kwargs): pass
	def onRespawnMode(self, *args, **kwargs): pass
	def onServerAim(self, *args, **kwargs): pass
	def onSetEquipmentID(self, *args, **kwargs): pass
	def onSniperMode(self, *args, **kwargs): pass
	ping = property(lambda self: None)
	playbackSpeed = property(lambda self: None)
	playerVehicleID = property(lambda self: None)
	playerVehicleIDChangedCallback = property(lambda self: None)
	postTickCallback = property(lambda self: None)
	def processFinish(self, *args, **kwargs): pass
	recBattleModeTag = property(lambda self: None)
	recMapName = property(lambda self: None)
	recPlayerVehicleName = property(lambda self: None)
	def registerWotReplayFileExtension(self, *args, **kwargs): pass
	replayFinishedCallback = property(lambda self: None)
	replayMetaDataCallback = property(lambda self: None)
	replayTerminatedCallback = property(lambda self: None)
	def resetArenaPeriod(self, *args, **kwargs): pass
	scriptModalWindowsEnabled = property(lambda self: None)
	def serializeCallbackData(self, *args, **kwargs): pass
	serverAimCallback = property(lambda self: None)
	def setActiveConsumableSlot(self, *args, **kwargs): pass
	def setAimClipPosition(self, *args, **kwargs): pass
	def setArcadeGunMarkerSize(self, *args, **kwargs): pass
	def setArenaInfoStr(self, *args, **kwargs): pass
	def setArenaStatisticsStr(self, *args, **kwargs): pass
	def setDataCallback(self, *args, **kwargs): pass
	def setDualAccMarkerSize(self, *args, **kwargs): pass
	def setGunReloadTime(self, *args, **kwargs): pass
	def setReplayTimes(*args, **kwargs): pass
	def setResultingFileName(self, *args, **kwargs): pass
	def setSPGGunMarkerParams(self, *args, **kwargs): pass
	def setupAvatarMethodExcludeFilter(self, *args, **kwargs): pass
	def setupStreamExcludeFilter(self, *args, **kwargs): pass
	sniperModeCallback = property(lambda self: None)
	def startPlayback(self, *args, **kwargs): pass
	def startRecording(self, *args, **kwargs): pass
	def stop(self, *args, **kwargs): pass
	turretYaw = property(lambda self: None)
	useSyncroniusResourceLoading = property(lambda self: None)
	warpFinishedCallback = property(lambda self: None)


class WGShadowForwardDecal(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGShadowForwardDecal'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	attached = property(lambda self: None)
	castsShadow = property(lambda self: None)
	def collideWithScene(self, *args, **kwargs): pass
	inWorld = property(lambda self: None)
	matrix = property(lambda self: None)
	def setLocalTransform(self, *args, **kwargs): pass
	def setup(self, *args, **kwargs): pass


class WGSpamFilter(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGSpamFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def removeSpam(self, *args, **kwargs): pass


class WGSplineTrack(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGSplineTrack'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class WGStickerModel(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGStickerModel'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addCounterSticker(self, *args, **kwargs): pass
	def addDamageSticker(self, *args, **kwargs): pass
	def addGunSticker(self, *args, **kwargs): pass
	def addSticker(self, *args, **kwargs): pass
	attached = property(lambda self: None)
	castsShadow = property(lambda self: None)
	def clear(self, *args, **kwargs): pass
	def delSticker(self, *args, **kwargs): pass
	inWorld = property(lambda self: None)
	matrix = property(lambda self: None)
	def setAlpha(self, *args, **kwargs): pass
	def setCounterStickerValue(self, *args, **kwargs): pass
	def setLODDistance(self, *args, **kwargs): pass
	def setTextureData(self, *args, **kwargs): pass
	def setupFadeout(self, *args, **kwargs): pass
	def setupSuperModel(self, *args, **kwargs): pass


class WGVehiclePhysics(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGVehiclePhysics'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	acceleration = property(lambda self: None)
	actualChassisTransform = property(lambda self: None)
	def addDamperSpring(self, *args, **kwargs): pass
	allowFreeze = property(lambda self: None)
	angAcceleration = property(lambda self: None)
	angVelocity = property(lambda self: None)
	def applyForce(self, *args, **kwargs): pass
	def applyForceLocal(self, *args, **kwargs): pass
	def applyForceLocalToCoM(self, *args, **kwargs): pass
	def applyForceToCoM(self, *args, **kwargs): pass
	def applyImpulse(self, *args, **kwargs): pass
	def applyImpulseLocal(self, *args, **kwargs): pass
	def applyImpulseLocalToCoM(self, *args, **kwargs): pass
	def applyImpulseToCoM(self, *args, **kwargs): pass
	def applyTorque(self, *args, **kwargs): pass
	def applyTorqueLocal(self, *args, **kwargs): pass
	auxDataForClient = property(lambda self: None)
	auxEnginePowerScale = property(lambda self: None)
	auxGroundRotFactors = property(lambda self: None)
	badState = property(lambda self: None)
	bkSpeedLimitBonus = property(lambda self: None)
	bkSpeedLimitScale = property(lambda self: None)
	bkwdPowerMod = property(lambda self: None)
	boundingRadius = property(lambda self: None)
	centerOfMass = property(lambda self: None)
	choker = property(lambda self: None)
	def configure(self, *args, **kwargs): pass
	cruiseSignals = property(lambda self: None)
	currentCenterOfMass = property(lambda self: None)
	def destructibleImpactCb(self, *args, **kwargs): pass
	def destructibleRequestCb(self, *args, **kwargs): pass
	distanceTraveled = property(lambda self: None)
	drownWarning = property(lambda self: None)
	def enableTurretCollision(self, *args, **kwargs): pass
	enginePowerMode = property(lambda self: None)
	def environmentEnergyCbThreshold(self, *args, **kwargs): pass
	externalForce = property(lambda self: None)
	def fireEngine(self, *args, **kwargs): pass
	forceApplied = property(lambda self: None)
	freezeAccelEpsilon = property(lambda self: None)
	freezeAngAccelEpsilon = property(lambda self: None)
	freezeAngVelEpsilon = property(lambda self: None)
	freezeVelEpsilon = property(lambda self: None)
	fwSpeedLimitBonus = property(lambda self: None)
	fwSpeedLimitScale = property(lambda self: None)
	gear = property(lambda self: None)
	def getAggressiveImpacts(self, *args, **kwargs): pass
	def getPointVelocity(self, *args, **kwargs): pass
	def getRollerPosition(self, *args, **kwargs): pass
	def getTouchedGround(self, *args, **kwargs): pass
	def getTouchedMatkind(self, *args, **kwargs): pass
	gotCarcassContact = property(lambda self: None)
	gotTracksContact = property(lambda self: None)
	gravity = property(lambda self: None)
	groundResistances = property(lambda self: None)
	groundType = property(lambda self: None)
	handbrake = property(lambda self: None)
	hullCOMZ = property(lambda self: None)
	hullCollisionReaction = property(lambda self: None)
	hullContactPt = property(lambda self: None)
	hullDamageMp = property(lambda self: None)
	hullPitchCorrection = property(lambda self: None)
	hullPitchCorrectionAllowed = property(lambda self: None)
	hullPitchCorrectionSector = property(lambda self: None)
	hydroResistanceFactor = property(lambda self: None)
	hydroResistanceRotFactor = property(lambda self: None)
	isFrozen = property(lambda self: None)
	isFrozenDuringFrame = property(lambda self: None)
	isOutOfControl = property(lambda self: None)
	isPitchHullAimingEnabled = property(lambda self: None)
	isSpeedtreeDestroyed = property(lambda self: None)
	isYawHullAimingEnabled = property(lambda self: None)
	lastTickMatrix = property(lambda self: None)
	majorDestructible = property(lambda self: None)
	mass = property(lambda self: None)
	matrix = property(lambda self: None)
	maxUnaidedRPM = property(lambda self: None)
	movementSignals = property(lambda self: None)
	normalisedRPM = property(lambda self: None)
	def onBecameFrozenCb(self, *args, **kwargs): pass
	def onBecameStillCb(self, *args, **kwargs): pass
	onEngineModeChangedCb = property(lambda self: None)
	def onEnvironmentCollisionCb(self, *args, **kwargs): pass
	def onFrictionWithVehicleCb(self, *args, **kwargs): pass
	def onKinematicsChangedCb(self, *args, **kwargs): pass
	def onMiscDataChangedCb(self, *args, **kwargs): pass
	def onRammingCb(self, *args, **kwargs): pass
	def onResurrectVehicle(self, *args, **kwargs): pass
	def onSideMovementChangedCb(self, *args, **kwargs): pass
	def onVehicleStatusChanged(self, *args, **kwargs): pass
	owner = property(lambda self: None)
	quietRotationEnabled = property(lambda self: None)
	def removeAllDamperSprings(self, *args, **kwargs): pass
	def removeAllSubscriptions(self, *args, **kwargs): pass
	def rollback(self, *args, **kwargs): pass
	rpm = property(lambda self: None)
	rspeed = property(lambda self: None)
	def setArenaBounds(self, *args, **kwargs): pass
	def setDamperSpringsLength(self, *args, **kwargs): pass
	def setHullAimingAnglesDelta(self, *args, **kwargs): pass
	def setSignal(self, *args, **kwargs): pass
	siegeModeState = property(lambda self: None)
	simulationYBound = property(lambda self: None)
	speed = property(lambda self: None)
	speedFromPreviousTick = property(lambda self: None)
	speedtreeReaction = property(lambda self: None)
	stabilisedMatrixLatency = property(lambda self: None)
	stabilisedMatrixWithLatency = property(lambda self: None)
	staticCollisionNormal = property(lambda self: None)
	staticCollisionPt = property(lambda self: None)
	staticMode = property(lambda self: None)
	def subscribeAfterSimulation(self, *args, **kwargs): pass
	def subscribeBeforeSimulation(self, *args, **kwargs): pass
	ticksFromLastCollision = property(lambda self: None)
	timeAfterLanding = property(lambda self: None)
	torqueApplied = property(lambda self: None)
	torqueModifier = property(lambda self: None)
	def touchGround(self, *args, **kwargs): pass
	def unsubscribeAfterSimulation(self, *args, **kwargs): pass
	def unsubscribeBeforeSimulation(self, *args, **kwargs): pass
	def updateSettings(self, *args, **kwargs): pass
	vehicleID = property(lambda self: None)
	velocity = property(lambda self: None)


class WGTankPhysics(WGVehiclePhysics):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGTankPhysics'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	acceleration = property(lambda self: None)
	actualChassisTransform = property(lambda self: None)
	def addDamperSpring(self, *args, **kwargs): pass
	allowFreeze = property(lambda self: None)
	angAcceleration = property(lambda self: None)
	angVelocity = property(lambda self: None)
	def applyForce(self, *args, **kwargs): pass
	def applyForceLocal(self, *args, **kwargs): pass
	def applyForceLocalToCoM(self, *args, **kwargs): pass
	def applyForceToCoM(self, *args, **kwargs): pass
	def applyImpulse(self, *args, **kwargs): pass
	def applyImpulseLocal(self, *args, **kwargs): pass
	def applyImpulseLocalToCoM(self, *args, **kwargs): pass
	def applyImpulseToCoM(self, *args, **kwargs): pass
	def applyTorque(self, *args, **kwargs): pass
	def applyTorqueLocal(self, *args, **kwargs): pass
	auxDataForClient = property(lambda self: None)
	auxEnginePowerScale = property(lambda self: None)
	auxGroundRotFactors = property(lambda self: None)
	badState = property(lambda self: None)
	bkSpeedLimitBonus = property(lambda self: None)
	bkSpeedLimitScale = property(lambda self: None)
	bkwdPowerMod = property(lambda self: None)
	boundingRadius = property(lambda self: None)
	centerOfMass = property(lambda self: None)
	choker = property(lambda self: None)
	def configure(self, *args, **kwargs): pass
	cruiseSignals = property(lambda self: None)
	currentCenterOfMass = property(lambda self: None)
	def destructibleImpactCb(self, *args, **kwargs): pass
	def destructibleRequestCb(self, *args, **kwargs): pass
	distanceTraveled = property(lambda self: None)
	drownWarning = property(lambda self: None)
	def enableTurretCollision(self, *args, **kwargs): pass
	enginePowerMode = property(lambda self: None)
	def environmentEnergyCbThreshold(self, *args, **kwargs): pass
	externalForce = property(lambda self: None)
	def fireEngine(self, *args, **kwargs): pass
	forceApplied = property(lambda self: None)
	freezeAccelEpsilon = property(lambda self: None)
	freezeAngAccelEpsilon = property(lambda self: None)
	freezeAngVelEpsilon = property(lambda self: None)
	freezeVelEpsilon = property(lambda self: None)
	fwSpeedLimitBonus = property(lambda self: None)
	fwSpeedLimitScale = property(lambda self: None)
	gear = property(lambda self: None)
	def getAggressiveImpacts(self, *args, **kwargs): pass
	def getPointVelocity(self, *args, **kwargs): pass
	def getRollerPosition(self, *args, **kwargs): pass
	def getTouchedGround(self, *args, **kwargs): pass
	def getTouchedMatkind(self, *args, **kwargs): pass
	gotCarcassContact = property(lambda self: None)
	gotTracksContact = property(lambda self: None)
	gravity = property(lambda self: None)
	groundResistances = property(lambda self: None)
	groundType = property(lambda self: None)
	handbrake = property(lambda self: None)
	hullCOMZ = property(lambda self: None)
	hullCollisionReaction = property(lambda self: None)
	hullContactPt = property(lambda self: None)
	hullDamageMp = property(lambda self: None)
	hullPitchCorrection = property(lambda self: None)
	hullPitchCorrectionAllowed = property(lambda self: None)
	hullPitchCorrectionSector = property(lambda self: None)
	hydroResistanceFactor = property(lambda self: None)
	hydroResistanceRotFactor = property(lambda self: None)
	isFrozen = property(lambda self: None)
	isFrozenDuringFrame = property(lambda self: None)
	isLeftTrackBroken = property(lambda self: None)
	isOutOfControl = property(lambda self: None)
	isPitchHullAimingEnabled = property(lambda self: None)
	isRightTrackBroken = property(lambda self: None)
	isSpeedtreeDestroyed = property(lambda self: None)
	isYawHullAimingEnabled = property(lambda self: None)
	lastTickMatrix = property(lambda self: None)
	leftTrackBrakeForce = property(lambda self: None)
	leftTrackScroll = property(lambda self: None)
	majorDestructible = property(lambda self: None)
	mass = property(lambda self: None)
	matrix = property(lambda self: None)
	maxUnaidedRPM = property(lambda self: None)
	movementSignals = property(lambda self: None)
	normalisedRPM = property(lambda self: None)
	def onBecameFrozenCb(self, *args, **kwargs): pass
	def onBecameStillCb(self, *args, **kwargs): pass
	onEngineModeChangedCb = property(lambda self: None)
	def onEnvironmentCollisionCb(self, *args, **kwargs): pass
	def onFrictionWithVehicleCb(self, *args, **kwargs): pass
	def onKinematicsChangedCb(self, *args, **kwargs): pass
	def onMiscDataChangedCb(self, *args, **kwargs): pass
	def onRammingCb(self, *args, **kwargs): pass
	def onResurrectVehicle(self, *args, **kwargs): pass
	def onSideMovementChangedCb(self, *args, **kwargs): pass
	def onVehicleStatusChanged(self, *args, **kwargs): pass
	owner = property(lambda self: None)
	quietRotationEnabled = property(lambda self: None)
	def removeAllDamperSprings(self, *args, **kwargs): pass
	def removeAllSubscriptions(self, *args, **kwargs): pass
	rightTrackBrakeForce = property(lambda self: None)
	rightTrackScroll = property(lambda self: None)
	def rollback(self, *args, **kwargs): pass
	rpm = property(lambda self: None)
	rspeed = property(lambda self: None)
	def setArenaBounds(self, *args, **kwargs): pass
	def setDamperSpringsLength(self, *args, **kwargs): pass
	def setHullAimingAnglesDelta(self, *args, **kwargs): pass
	def setSignal(self, *args, **kwargs): pass
	siegeModeState = property(lambda self: None)
	simulationYBound = property(lambda self: None)
	speed = property(lambda self: None)
	speedFromPreviousTick = property(lambda self: None)
	speedtreeReaction = property(lambda self: None)
	stabilisedMatrixLatency = property(lambda self: None)
	stabilisedMatrixWithLatency = property(lambda self: None)
	staticCollisionNormal = property(lambda self: None)
	staticCollisionPt = property(lambda self: None)
	staticMode = property(lambda self: None)
	def subscribeAfterSimulation(self, *args, **kwargs): pass
	def subscribeBeforeSimulation(self, *args, **kwargs): pass
	ticksFromLastCollision = property(lambda self: None)
	timeAfterLanding = property(lambda self: None)
	torqueApplied = property(lambda self: None)
	torqueModifier = property(lambda self: None)
	def touchGround(self, *args, **kwargs): pass
	def unsubscribeAfterSimulation(self, *args, **kwargs): pass
	def unsubscribeBeforeSimulation(self, *args, **kwargs): pass
	def updateSettings(self, *args, **kwargs): pass
	vehicleID = property(lambda self: None)
	velocity = property(lambda self: None)


class WGTextureFashion(PyMaterialFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGTextureFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def setTexture(self, *args, **kwargs): pass


class WGTurretFilter(WGEntityFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGTurretFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	allowCustomResets = True
	allowLagCollisions = True
	canExtrapolateOnLag = True
	defaultMaxTimeBetweenInputs = 2.0
	enableClientFilters = True
	def enableLagDetection(self, *args, **kwargs): pass
	enableSphericalInterpolation = property(lambda self: None)
	ignoreInputs = property(lambda self: None)
	ignoreNextReset = property(lambda self: None)
	def input(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	latestInput = property(lambda self: None)
	maxMove = property(lambda self: None)
	maxTimeBetweenInputs = property(lambda self: None)
	movementExtrapolationData = property(lambda self: None)
	def output(self, *args, **kwargs): pass
	def reset(self, *args, **kwargs): pass
	def segmentMayHitEntity(self, *args, **kwargs): pass
	def setScriptInputCallback(self, *args, **kwargs): pass
	def transferInput(self, *args, **kwargs): pass
	def transferInputAsVehicle(self, *args, **kwargs): pass


class WGVehicleFashion(WGBaseFashion):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGVehicleFashion'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addMaterialHandler(self, *args, **kwargs): pass
	def addTrackMaterialHandler(self, *args, **kwargs): pass
	def changeMaterialsVisibility(self, *args, **kwargs): pass
	def changeTrackVisibility(self, *args, **kwargs): pass
	def disowned(self, *args, **kwargs): pass
	def getMaterialHandlers(self, *args, **kwargs): pass
	def getTrackMaterialHandlers(self, *args, **kwargs): pass
	def removeCamouflage(self, *args, **kwargs): pass
	def removePhysicalTracks(self, *args, **kwargs): pass
	def setCamouflage(self, *args, **kwargs): pass
	def setPhysicalTracks(self, *args, **kwargs): pass
	def setSplineTracks(self, *args, **kwargs): pass
	def setTracksMaterials(self, *args, **kwargs): pass


class WGVehicleFilter(WGEntityFilter):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGVehicleFilter'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	acceleration = property(lambda self: None)
	def addTriangle(self, *args, **kwargs): pass
	allowCustomResets = True
	allowLagCollisions = True
	allowStrafeCompensation = property(lambda self: None)
	angularSpeed = property(lambda self: None)
	averageRotationSpeed = property(lambda self: None)
	def averageRotationSpeed_gen(*args, **kwargs): pass
	averageSpeed = property(lambda self: None)
	def averageSpeed_gen(*args, **kwargs): pass
	bodyMatrix = property(lambda self: None)
	canExtrapolateOnLag = True
	def clearTriangles(self, *args, **kwargs): pass
	defaultMaxTimeBetweenInputs = 2.0
	defaultVelocityErrorCompensation = 0.5
	enableClientFilters = True
	def enableLagDetection(self, *args, **kwargs): pass
	def enableStabilisedMatrix(self, *args, **kwargs): pass
	def forceGroundPlacingMatrix(self, *args, **kwargs): pass
	def getVehiclePhysics(self, *args, **kwargs): pass
	groundDeformationRate = property(lambda self: None)
	groundPlacingMatrix = property(lambda self: None)
	groundPlacingMatrixFiltered = property(lambda self: None)
	gunMatrix = property(lambda self: None)
	hullLocalPosition = property(lambda self: None)
	ignoreInputs = property(lambda self: None)
	ignoreNextReset = property(lambda self: None)
	def input(self, *args, **kwargs): pass
	instantaneousRotationSpeed = property(lambda self: None)
	def instantaneousRotationSpeed_gen(*args, **kwargs): pass
	instantaneousSpeed = property(lambda self: None)
	def instantaneousSpeed_gen(*args, **kwargs): pass
	def interpolateStabilisedMatrix(self, *args, **kwargs): pass
	isLaggingNow = property(lambda self: None)
	isStrafing = property(lambda self: None)
	latestInput = property(lambda self: None)
	leftTrackScroll = property(lambda self: None)
	def leftTrackScroll_gen(*args, **kwargs): pass
	longitudinalSpeed = property(lambda self: None)
	maxMove = property(lambda self: None)
	maxTimeBetweenInputs = property(lambda self: None)
	movementExtrapolationData = property(lambda self: None)
	movementInfo = property(lambda self: None)
	def notifyInputKeysDown(self, *args, **kwargs): pass
	numLeftTrackContacts = property(lambda self: None)
	numRightTrackContacts = property(lambda self: None)
	def output(self, *args, **kwargs): pass
	physicsInfo = property(lambda self: None)
	placingCompensationMatrix = property(lambda self: None)
	placingOnGround = property(lambda self: None)
	def reset(self, *args, **kwargs): pass
	rightTrackScroll = property(lambda self: None)
	def rightTrackScroll_gen(*args, **kwargs): pass
	def segmentMayHitEntity(self, *args, **kwargs): pass
	def setScriptInputCallback(self, *args, **kwargs): pass
	def setTracksSpeed(self, *args, **kwargs): pass
	def setVehiclePhysics(self, *args, **kwargs): pass
	speedInfo = property(lambda self: None)
	stabilisedMatrix = property(lambda self: None)
	strafeSpeed = property(lambda self: None)
	surfaceCurvature = property(lambda self: None)
	suspCompressionRate = property(lambda self: None)
	def syncGunAngles(self, *args, **kwargs): pass
	def syncStabilisedYPR(self, *args, **kwargs): pass
	def transferInput(self, *args, **kwargs): pass
	def transferInputAsVehicle(self, *args, **kwargs): pass
	turretMatrix = property(lambda self: None)
	vehicleCollisionCallback = property(lambda self: None)
	vehicleMinNormalY = property(lambda self: None)
	vehicleWidth = property(lambda self: None)
	velocity = property(lambda self: None)
	velocityErrorCompensation = property(lambda self: None)


class WGWarplaneMotor(Motor):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGWarplaneMotor'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	owner = property(lambda self: None)
	def restart(self, *args, **kwargs): pass
	def stop(self, *args, **kwargs): pass
	totalTime = property(lambda self: None)
	warplaneAlpha = property(lambda self: None)


class WGWheeledPhysics(WGVehiclePhysics):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGWheeledPhysics'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	acceleration = property(lambda self: None)
	actualChassisTransform = property(lambda self: None)
	def addDamperSpring(self, *args, **kwargs): pass
	allowFreeze = property(lambda self: None)
	angAcceleration = property(lambda self: None)
	angVelocity = property(lambda self: None)
	def applyBurnoutImpulse(self, *args, **kwargs): pass
	def applyForce(self, *args, **kwargs): pass
	def applyForceLocal(self, *args, **kwargs): pass
	def applyForceLocalToCoM(self, *args, **kwargs): pass
	def applyForceToCoM(self, *args, **kwargs): pass
	def applyImpulse(self, *args, **kwargs): pass
	def applyImpulseLocal(self, *args, **kwargs): pass
	def applyImpulseLocalToCoM(self, *args, **kwargs): pass
	def applyImpulseToCoM(self, *args, **kwargs): pass
	def applyTorque(self, *args, **kwargs): pass
	def applyTorqueLocal(self, *args, **kwargs): pass
	auxDataForClient = property(lambda self: None)
	auxEnginePowerScale = property(lambda self: None)
	auxGroundRotFactors = property(lambda self: None)
	badState = property(lambda self: None)
	bkSpeedLimitBonus = property(lambda self: None)
	bkSpeedLimitScale = property(lambda self: None)
	bkwdPowerMod = property(lambda self: None)
	boundingRadius = property(lambda self: None)
	centerOfMass = property(lambda self: None)
	choker = property(lambda self: None)
	def configure(self, *args, **kwargs): pass
	cruiseSignals = property(lambda self: None)
	currentCenterOfMass = property(lambda self: None)
	def destructibleImpactCb(self, *args, **kwargs): pass
	def destructibleRequestCb(self, *args, **kwargs): pass
	distanceTraveled = property(lambda self: None)
	drownWarning = property(lambda self: None)
	def enableTurretCollision(self, *args, **kwargs): pass
	enginePowerMode = property(lambda self: None)
	def environmentEnergyCbThreshold(self, *args, **kwargs): pass
	externalForce = property(lambda self: None)
	def fireEngine(self, *args, **kwargs): pass
	forceApplied = property(lambda self: None)
	freezeAccelEpsilon = property(lambda self: None)
	freezeAngAccelEpsilon = property(lambda self: None)
	freezeAngVelEpsilon = property(lambda self: None)
	freezeVelEpsilon = property(lambda self: None)
	fwSpeedLimitBonus = property(lambda self: None)
	fwSpeedLimitScale = property(lambda self: None)
	gear = property(lambda self: None)
	getActualWheelTransforms = property(lambda self: None)
	def getAggressiveImpacts(self, *args, **kwargs): pass
	def getPointVelocity(self, *args, **kwargs): pass
	def getRollerPosition(self, *args, **kwargs): pass
	def getTouchedGround(self, *args, **kwargs): pass
	def getTouchedMatkind(self, *args, **kwargs): pass
	gotCarcassContact = property(lambda self: None)
	gotTracksContact = property(lambda self: None)
	gravity = property(lambda self: None)
	groundResistances = property(lambda self: None)
	groundType = property(lambda self: None)
	handbrake = property(lambda self: None)
	hullCOMZ = property(lambda self: None)
	hullCollisionReaction = property(lambda self: None)
	hullContactPt = property(lambda self: None)
	hullDamageMp = property(lambda self: None)
	hullPitchCorrection = property(lambda self: None)
	hullPitchCorrectionAllowed = property(lambda self: None)
	hullPitchCorrectionSector = property(lambda self: None)
	hydroResistanceFactor = property(lambda self: None)
	hydroResistanceRotFactor = property(lambda self: None)
	isFrozen = property(lambda self: None)
	isFrozenDuringFrame = property(lambda self: None)
	isOutOfControl = property(lambda self: None)
	isPitchHullAimingEnabled = property(lambda self: None)
	isSpeedtreeDestroyed = property(lambda self: None)
	isYawHullAimingEnabled = property(lambda self: None)
	lastTickMatrix = property(lambda self: None)
	majorDestructible = property(lambda self: None)
	mass = property(lambda self: None)
	matrix = property(lambda self: None)
	maxUnaidedRPM = property(lambda self: None)
	movementSignals = property(lambda self: None)
	normalisedRPM = property(lambda self: None)
	def onBecameFrozenCb(self, *args, **kwargs): pass
	def onBecameStillCb(self, *args, **kwargs): pass
	onEngineModeChangedCb = property(lambda self: None)
	def onEnvironmentCollisionCb(self, *args, **kwargs): pass
	def onFrictionWithVehicleCb(self, *args, **kwargs): pass
	def onKinematicsChangedCb(self, *args, **kwargs): pass
	def onMiscDataChangedCb(self, *args, **kwargs): pass
	def onRammingCb(self, *args, **kwargs): pass
	def onResurrectVehicle(self, *args, **kwargs): pass
	def onSideMovementChangedCb(self, *args, **kwargs): pass
	onSteeringAnglesChangedCb = property(lambda self: None)
	def onVehicleStatusChanged(self, *args, **kwargs): pass
	onWheelsScrollChangedCb = property(lambda self: None)
	owner = property(lambda self: None)
	quietRotationEnabled = property(lambda self: None)
	def removeAllDamperSprings(self, *args, **kwargs): pass
	def removeAllSubscriptions(self, *args, **kwargs): pass
	def rollback(self, *args, **kwargs): pass
	rotationSpeedFactor = property(lambda self: None)
	rpm = property(lambda self: None)
	rspeed = property(lambda self: None)
	def setArenaBounds(self, *args, **kwargs): pass
	def setDamperSpringsLength(self, *args, **kwargs): pass
	def setHullAimingAnglesDelta(self, *args, **kwargs): pass
	def setSignal(self, *args, **kwargs): pass
	def setWheelBroken(self, *args, **kwargs): pass
	siegeModeState = property(lambda self: None)
	simulationYBound = property(lambda self: None)
	speed = property(lambda self: None)
	speedFromPreviousTick = property(lambda self: None)
	speedtreeReaction = property(lambda self: None)
	stabilisedMatrixLatency = property(lambda self: None)
	stabilisedMatrixWithLatency = property(lambda self: None)
	staticCollisionNormal = property(lambda self: None)
	staticCollisionPt = property(lambda self: None)
	staticMode = property(lambda self: None)
	def subscribeAfterSimulation(self, *args, **kwargs): pass
	def subscribeBeforeSimulation(self, *args, **kwargs): pass
	ticksFromLastCollision = property(lambda self: None)
	timeAfterLanding = property(lambda self: None)
	torqueApplied = property(lambda self: None)
	torqueModifier = property(lambda self: None)
	def touchGround(self, *args, **kwargs): pass
	def unsubscribeAfterSimulation(self, *args, **kwargs): pass
	def unsubscribeBeforeSimulation(self, *args, **kwargs): pass
	def updateSettings(self, *args, **kwargs): pass
	vehicleID = property(lambda self: None)
	velocity = property(lambda self: None)


class WGWinNotifier(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WGWinNotifier'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def onBattleBeginning(self, *args, **kwargs): pass
	def onInvitation(self, *args, **kwargs): pass
	def resetTaskbar(self, *args, **kwargs): pass

WGWindowsNotifier = WGWinNotifier()
def WG_dirtEnabled(*args, **kwargs): pass
def WG_loadDirtPreset(*args, **kwargs): pass
WINDOWED_FIXED_SIZE = BorderlessBehaviour.WINDOWED_FIXED_SIZE
WINDOWED_UNCONSTRAINED = BorderlessBehaviour.WINDOWED_UNCONSTRAINED
WORKAREA_MAXIMIZED = BorderlessBehaviour.WORKAREA_MAXIMIZED

class WgVehicleOutput(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'WgVehicleOutput'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	angularVelocity = property(lambda self: None)
	direction = property(lambda self: None)
	position = property(lambda self: None)
	space = property(lambda self: None)
	vehicle = property(lambda self: None)
	velocity = property(lambda self: None)

WindowModeBorderless = 2
WindowModeDefaultFullscreen = 1
WindowModeExclusiveFullscreen = 1
WindowModeWindowed = 0
X1R5G5B5 = ResourceFormat.X1R5G5B5
X8B8G8R8 = ResourceFormat.X8B8G8R8
X8R8G8B8 = ResourceFormat.X8R8G8B8

class XmppClient(pybind11_object):
	
	class ConnectionState(pybind11_object):
		STATE_AUTHENTICATING = ConnectionState.STATE_AUTHENTICATING
		STATE_CONNECTED = ConnectionState.STATE_CONNECTED
		STATE_CONNECTING = ConnectionState.STATE_CONNECTING
		STATE_DISCONNECTED = ConnectionState.STATE_DISCONNECTED
		STATE_INITIALIZING = ConnectionState.STATE_INITIALIZING
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  STATE_AUTHENTICATING\n\n  STATE_DISCONNECTED\n\n  STATE_CONNECTING\n\n  STATE_CONNECTED\n\n  STATE_INITIALIZING'
		__entries = {u'STATE_AUTHENTICATING': (ConnectionState.STATE_AUTHENTICATING, None), u'STATE_DISCONNECTED': (ConnectionState.STATE_DISCONNECTED, None), u'STATE_CONNECTING': (ConnectionState.STATE_CONNECTING, None), u'STATE_CONNECTED': (ConnectionState.STATE_CONNECTED, None), u'STATE_INITIALIZING': (ConnectionState.STATE_INITIALIZING, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'STATE_AUTHENTICATING': ConnectionState.STATE_AUTHENTICATING, u'STATE_DISCONNECTED': ConnectionState.STATE_DISCONNECTED, u'STATE_INITIALIZING': ConnectionState.STATE_INITIALIZING, u'STATE_CONNECTING': ConnectionState.STATE_CONNECTING, u'STATE_CONNECTED': ConnectionState.STATE_CONNECTED}
		__module__ = 'BigWorld'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'XmppClient.ConnectionState'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	DISCONNECT_AUTHENTICATION = DisconnectReason.DISCONNECT_AUTHENTICATION
	DISCONNECT_BY_REQUEST = DisconnectReason.DISCONNECT_BY_REQUEST
	DISCONNECT_OTHER_ERROR = DisconnectReason.DISCONNECT_OTHER_ERROR
	
	class DisconnectReason(pybind11_object):
		DISCONNECT_AUTHENTICATION = DisconnectReason.DISCONNECT_AUTHENTICATION
		DISCONNECT_BY_REQUEST = DisconnectReason.DISCONNECT_BY_REQUEST
		DISCONNECT_OTHER_ERROR = DisconnectReason.DISCONNECT_OTHER_ERROR
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  DISCONNECT_AUTHENTICATION\n\n  DISCONNECT_BY_REQUEST\n\n  DISCONNECT_OTHER_ERROR'
		__entries = {u'DISCONNECT_AUTHENTICATION': (DisconnectReason.DISCONNECT_AUTHENTICATION, None), u'DISCONNECT_BY_REQUEST': (DisconnectReason.DISCONNECT_BY_REQUEST, None), u'DISCONNECT_OTHER_ERROR': (DisconnectReason.DISCONNECT_OTHER_ERROR, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'DISCONNECT_AUTHENTICATION': DisconnectReason.DISCONNECT_AUTHENTICATION, u'DISCONNECT_BY_REQUEST': DisconnectReason.DISCONNECT_BY_REQUEST, u'DISCONNECT_OTHER_ERROR': DisconnectReason.DISCONNECT_OTHER_ERROR}
		__module__ = 'BigWorld'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'XmppClient.DisconnectReason'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	
	class IQ(pybind11_object):
		IQ_TYPE_ERROR = IQ.IQ_TYPE_ERROR
		IQ_TYPE_GET = IQ.IQ_TYPE_GET
		IQ_TYPE_INVALID = IQ.IQ_TYPE_INVALID
		IQ_TYPE_RESULT = IQ.IQ_TYPE_RESULT
		IQ_TYPE_SET = IQ.IQ_TYPE_SET
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  IQ_TYPE_RESULT\n\n  IQ_TYPE_INVALID\n\n  IQ_TYPE_ERROR\n\n  IQ_TYPE_SET\n\n  IQ_TYPE_GET'
		__entries = {u'IQ_TYPE_RESULT': (IQ.IQ_TYPE_RESULT, None), u'IQ_TYPE_INVALID': (IQ.IQ_TYPE_INVALID, None), u'IQ_TYPE_ERROR': (IQ.IQ_TYPE_ERROR, None), u'IQ_TYPE_SET': (IQ.IQ_TYPE_SET, None), u'IQ_TYPE_GET': (IQ.IQ_TYPE_GET, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'IQ_TYPE_RESULT': IQ.IQ_TYPE_RESULT, u'IQ_TYPE_INVALID': IQ.IQ_TYPE_INVALID, u'IQ_TYPE_ERROR': IQ.IQ_TYPE_ERROR, u'IQ_TYPE_GET': IQ.IQ_TYPE_GET, u'IQ_TYPE_SET': IQ.IQ_TYPE_SET}
		__module__ = 'BigWorld'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'XmppClient.IQ'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	IQ_TYPE_ERROR = IQ.IQ_TYPE_ERROR
	IQ_TYPE_GET = IQ.IQ_TYPE_GET
	IQ_TYPE_INVALID = IQ.IQ_TYPE_INVALID
	IQ_TYPE_RESULT = IQ.IQ_TYPE_RESULT
	IQ_TYPE_SET = IQ.IQ_TYPE_SET
	LOG_LEVEL_DEBUG = LogLevel.LOG_LEVEL_DEBUG
	LOG_LEVEL_ERROR = LogLevel.LOG_LEVEL_ERROR
	LOG_LEVEL_WARNING = LogLevel.LOG_LEVEL_WARNING
	
	class LogLevel(pybind11_object):
		LOG_LEVEL_DEBUG = LogLevel.LOG_LEVEL_DEBUG
		LOG_LEVEL_ERROR = LogLevel.LOG_LEVEL_ERROR
		LOG_LEVEL_WARNING = LogLevel.LOG_LEVEL_WARNING
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  LOG_LEVEL_WARNING\n\n  LOG_LEVEL_DEBUG\n\n  LOG_LEVEL_ERROR'
		__entries = {u'LOG_LEVEL_WARNING': (LogLevel.LOG_LEVEL_WARNING, None), u'LOG_LEVEL_DEBUG': (LogLevel.LOG_LEVEL_DEBUG, None), u'LOG_LEVEL_ERROR': (LogLevel.LOG_LEVEL_ERROR, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'LOG_LEVEL_WARNING': LogLevel.LOG_LEVEL_WARNING, u'LOG_LEVEL_DEBUG': LogLevel.LOG_LEVEL_DEBUG, u'LOG_LEVEL_ERROR': LogLevel.LOG_LEVEL_ERROR}
		__module__ = 'BigWorld'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'XmppClient.LogLevel'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	PRESENCE_AVAILABLE = Presence.PRESENCE_AVAILABLE
	PRESENCE_AWAY = Presence.PRESENCE_AWAY
	PRESENCE_CHAT = Presence.PRESENCE_CHAT
	PRESENCE_DND = Presence.PRESENCE_DND
	PRESENCE_UNAVAILABLE = Presence.PRESENCE_UNAVAILABLE
	PRESENCE_UNKNOWN = Presence.PRESENCE_UNKNOWN
	PRESENCE_XA = Presence.PRESENCE_XA
	
	class Presence(pybind11_object):
		PRESENCE_AVAILABLE = Presence.PRESENCE_AVAILABLE
		PRESENCE_AWAY = Presence.PRESENCE_AWAY
		PRESENCE_CHAT = Presence.PRESENCE_CHAT
		PRESENCE_DND = Presence.PRESENCE_DND
		PRESENCE_UNAVAILABLE = Presence.PRESENCE_UNAVAILABLE
		PRESENCE_UNKNOWN = Presence.PRESENCE_UNKNOWN
		PRESENCE_XA = Presence.PRESENCE_XA
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  PRESENCE_DND\n\n  PRESENCE_AWAY\n\n  PRESENCE_UNKNOWN\n\n  PRESENCE_XA\n\n  PRESENCE_UNAVAILABLE\n\n  PRESENCE_AVAILABLE\n\n  PRESENCE_CHAT'
		__entries = {u'PRESENCE_DND': (Presence.PRESENCE_DND, None), u'PRESENCE_AWAY': (Presence.PRESENCE_AWAY, None), u'PRESENCE_UNKNOWN': (Presence.PRESENCE_UNKNOWN, None), u'PRESENCE_XA': (Presence.PRESENCE_XA, None), u'PRESENCE_UNAVAILABLE': (Presence.PRESENCE_UNAVAILABLE, None), u'PRESENCE_AVAILABLE': (Presence.PRESENCE_AVAILABLE, None), u'PRESENCE_CHAT': (Presence.PRESENCE_CHAT, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'PRESENCE_DND': Presence.PRESENCE_DND, u'PRESENCE_AWAY': Presence.PRESENCE_AWAY, u'PRESENCE_UNKNOWN': Presence.PRESENCE_UNKNOWN, u'PRESENCE_XA': Presence.PRESENCE_XA, u'PRESENCE_UNAVAILABLE': Presence.PRESENCE_UNAVAILABLE, u'PRESENCE_AVAILABLE': Presence.PRESENCE_AVAILABLE, u'PRESENCE_CHAT': Presence.PRESENCE_CHAT}
		__module__ = 'BigWorld'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'XmppClient.Presence'
		def __reduce__(*args, **kwargs): pass
		def __reduce_ex__(*args, **kwargs): pass
		def __repr__(self, *args, **kwargs): pass
		def __setattr__(*args, **kwargs): pass
		def __setstate__(self, *args, **kwargs): pass
		def __sizeof__(*args, **kwargs): pass
		def __str__(*args, **kwargs): pass
		def __subclasshook__(*args, **kwargs): pass
		name = property(lambda self: None)
	
	STATE_AUTHENTICATING = ConnectionState.STATE_AUTHENTICATING
	STATE_CONNECTED = ConnectionState.STATE_CONNECTED
	STATE_CONNECTING = ConnectionState.STATE_CONNECTING
	STATE_DISCONNECTED = ConnectionState.STATE_DISCONNECTED
	STATE_INITIALIZING = ConnectionState.STATE_INITIALIZING
	SUBSCRIPTION_OFF = Subscription.SUBSCRIPTION_OFF
	SUBSCRIPTION_ON = Subscription.SUBSCRIPTION_ON
	SUBSCRIPTION_PENDING = Subscription.SUBSCRIPTION_PENDING
	
	class Subscription(pybind11_object):
		SUBSCRIPTION_OFF = Subscription.SUBSCRIPTION_OFF
		SUBSCRIPTION_ON = Subscription.SUBSCRIPTION_ON
		SUBSCRIPTION_PENDING = Subscription.SUBSCRIPTION_PENDING
		def __delattr__(*args, **kwargs): pass
		__doc__ = u'Members:\n\n  SUBSCRIPTION_OFF\n\n  SUBSCRIPTION_ON\n\n  SUBSCRIPTION_PENDING'
		__entries = {u'SUBSCRIPTION_OFF': (Subscription.SUBSCRIPTION_OFF, None), u'SUBSCRIPTION_ON': (Subscription.SUBSCRIPTION_ON, None), u'SUBSCRIPTION_PENDING': (Subscription.SUBSCRIPTION_PENDING, None)}
		def __eq__(self, *args, **kwargs): pass
		def __format__(*args, **kwargs): pass
		def __getattribute__(*args, **kwargs): pass
		def __getstate__(self, *args, **kwargs): pass
		def __hash__(self, *args, **kwargs): pass
		def __init__(self, *args, **kwargs): pass
		def __int__(self, *args, **kwargs): pass
		def __long__(self, *args, **kwargs): pass
		__members__ = {u'SUBSCRIPTION_OFF': Subscription.SUBSCRIPTION_OFF, u'SUBSCRIPTION_ON': Subscription.SUBSCRIPTION_ON, u'SUBSCRIPTION_PENDING': Subscription.SUBSCRIPTION_PENDING}
		__module__ = 'BigWorld'
		def __ne__(self, *args, **kwargs): pass
		def __new__(*args, **kwargs): pass
		__qualname__ = u'XmppClient.Subscription'
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
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'XmppClient'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def add(self, *args, **kwargs): pass
	def addStanzaFilter(self, *args, **kwargs): pass
	def connect(self, *args, **kwargs): pass
	def connectBosh(self, *args, **kwargs): pass
	connectionState = property(lambda self: None)
	def disconnect(self, *args, **kwargs): pass
	fullJid = property(lambda self: None)
	def login(self, *args, **kwargs): pass
	onConnect = property(lambda self: None)
	onDisconnect = property(lambda self: None)
	onHandleIq = property(lambda self: None)
	onHandleMsg = property(lambda self: None)
	onHandleMsgError = property(lambda self: None)
	onHandlePresence = property(lambda self: None)
	onHandlePresenceError = property(lambda self: None)
	onLog = property(lambda self: None)
	onNewRosterItem = property(lambda self: None)
	onReady = property(lambda self: None)
	onRosterItemRemove = property(lambda self: None)
	onRosterQuerySend = property(lambda self: None)
	onRosterResultReceived = property(lambda self: None)
	onSubscribe = property(lambda self: None)
	presence = property(lambda self: None)
	def remove(self, *args, **kwargs): pass
	def removeStanzaFilter(self, *args, **kwargs): pass
	def sendCustomMessage(self, *args, **kwargs): pass
	def sendCustomPresence(self, *args, **kwargs): pass
	def sendCustomQuery(self, *args, **kwargs): pass
	def sendMUCPresence(self, *args, **kwargs): pass
	def setSubscribed(self, *args, **kwargs): pass
	def setUnsubscribed(self, *args, **kwargs): pass
	def subscribe(self, *args, **kwargs): pass
	def unsubscribe(self, *args, **kwargs): pass

def _BWExceptHook(*args, **kwargs): pass
__doc__ = None
__name__ = 'BigWorld'
def __onThreadEnd(*args, **kwargs): pass
def __onThreadStart(*args, **kwargs): pass
__package__ = None
def addDecal(*args, **kwargs): pass
def addDecalGroup(*args, **kwargs): pass
def addIdleCallbackForDelay(*args, **kwargs): pass
def addMarkEnterToRegion(*args, **kwargs): pass
def addMarkExitFromRegion(*args, **kwargs): pass
def addModel(*args, **kwargs): pass
def addSpaceGeometryMapping(*args, **kwargs): pass
def addTextureFeed(*args, **kwargs): pass
def addUPLMessage(*args, **kwargs): pass
def addWatcher(*args, **kwargs): pass
allEntities = PyEntities()
def appendCameraCollider(*args, **kwargs): pass
def applyGraphicPreset(*args, **kwargs): pass
def autoDetectGraphicsSettings(*args, **kwargs): pass
def axisDirection(*args, **kwargs): pass
def buildBlueprint(*args, **kwargs): pass
cachedEntities = {}
def callback(*args, **kwargs): pass
def camera(*args, **kwargs): pass
def cameraSpaceID(*args, **kwargs): pass
def canToDowngradePreset(*args, **kwargs): pass
def cancelCallback(*args, **kwargs): pass
def changeFullScreenAspectRatio(*args, **kwargs): pass
def changeVideoMode(*args, **kwargs): pass
def checkAndRecalculateIfPositionInExtremeProjection(*args, **kwargs): pass
def checkUnattended(*args, **kwargs): pass
def clearAllSpaces(*args, **kwargs): pass
def clearBlueprint(*args, **kwargs): pass
def clearEntitiesAndSpaces(*args, **kwargs): pass
def clearSpace(*args, **kwargs): pass
def clearTextureReuseList(*args, **kwargs): pass
def clearTextureStreamingViewpoints(*args, **kwargs): pass
def collectLastMemoryCriticalEvent(*args, **kwargs): pass
def collectMemoryUsage(*args, **kwargs): pass
def collide(*args, **kwargs): pass
def commandLineLoginInfo(*args, **kwargs): pass
def commitPendingGraphicsSettings(*args, **kwargs): pass
component = u'client'
def connect(*args, **kwargs): pass
def connectedEntity(*args, **kwargs): pass
def consumerBuild(*args, **kwargs): pass
def controlEntity(*args, **kwargs): pass
def controlPointSetHeight(*args, **kwargs): pass
def createBrowser(*args, **kwargs): pass
def createEntity(*args, **kwargs): pass
def createPlayerEntity(*args, **kwargs): pass
def createSpace(*args, **kwargs): pass
def createWebView(*args, **kwargs): pass
def criticalExit(*args, **kwargs): pass
def currentGraphicPresetKey(*args, **kwargs): pass
def dcursor(*args, **kwargs): pass
def debugDropFilter(*args, **kwargs): pass
def debugModel(*args, **kwargs): pass
def debugNearPlane(*args, **kwargs): pass
def delModel(*args, **kwargs): pass
def delSpaceGeometryMapping(*args, **kwargs): pass
def delTextureFeed(*args, **kwargs): pass
def delWatcher(*args, **kwargs): pass
def delaySpaceLoad(*args, **kwargs): pass
def destroyBrowser(*args, **kwargs): pass
def destroyEntity(*args, **kwargs): pass
def destroyWebView(*args, **kwargs): pass
def detectGraphicsPresetFromSystemSettings(*args, **kwargs): pass
def disconnect(*args, **kwargs): pass
def enableBattleStatisticCollector(*args, **kwargs): pass
def enableBlueprintBuilding(*args, **kwargs): pass
def enableDRRAutoscaling(*args, **kwargs): pass
def enableEdgeDrawerVisual(*args, **kwargs): pass
def enableFreeCameraModeForShadowManager(*args, **kwargs): pass
def enableLoadingTimer(*args, **kwargs): pass
def enterSpace(*args, **kwargs): pass
entities = PyEntities()
def entity(*args, **kwargs): pass
def exit(*args, **kwargs): pass
def fetchURL(*args, **kwargs): pass
def finishDelayedLoading(*args, **kwargs): pass
def flushPythonLog(*args, **kwargs): pass
def generateGfxSettings(*args, **kwargs): pass
def getActiveMonitorIndex(*args, **kwargs): pass
def getAspectRatio(*args, **kwargs): pass
def getAutoDetectGraphicsSettingsScore(*args, **kwargs): pass
def getBattleFPS(*args, **kwargs): pass
def getBorderlessParameters(*args, **kwargs): pass
def getColorBCSSetup(*args, **kwargs): pass
def getColorBrightness(*args, **kwargs): pass
def getColorContrast(*args, **kwargs): pass
def getColorGradingStrength(*args, **kwargs): pass
def getColorSaturation(*args, **kwargs): pass
def getDRRAutoscalerBaseScale(*args, **kwargs): pass
def getDRRScale(*args, **kwargs): pass
def getExclusiveFullscreenMonitorIndex(*args, **kwargs): pass
def getExtensionsDirList(*args, **kwargs): pass
def getFPS(*args, **kwargs): pass
def getFileMappingMemory(*args, **kwargs): pass
def getFullScreenAspectRatio(*args, **kwargs): pass
def getGammaCorrection(*args, **kwargs): pass
def getGenericMemory(*args, **kwargs): pass
def getGraphicsPreset(*args, **kwargs): pass
def getGraphicsPresetPropertyNames(*args, **kwargs): pass
def getGraphicsPresets(*args, **kwargs): pass
def getGraphicsPresetsIndices(*args, **kwargs): pass
def getGraphicsSetting(*args, **kwargs): pass
def getGraphicsSettingApplyMethod(*args, **kwargs): pass
def getHeapMemory(*args, **kwargs): pass
def getImageMemory(*args, **kwargs): pass
def getIsImpassableZoneEnabled(*args, **kwargs): pass
def getMaterialKinds(*args, **kwargs): pass
def getMemoryInfoKB(*args, **kwargs): pass
def getScaleformMemory(*args, **kwargs): pass
def getStreamingMemory(*args, **kwargs): pass
def getSurfMemory(*args, **kwargs): pass
def getSystemPerformancePresetIdFromName(*args, **kwargs): pass
def getTextureFeed(*args, **kwargs): pass
def getUniProfMemory(*args, **kwargs): pass
def getWWiseMemory(*args, **kwargs): pass
def getWatcher(*args, **kwargs): pass
def getWatcherDir(*args, **kwargs): pass
def getWin32HeapMemory(*args, **kwargs): pass
def getWindowMode(*args, **kwargs): pass
def graphicSetting(*args, **kwargs): pass
def graphicSettingIsSupported(*args, **kwargs): pass
def graphicsSettings(*args, **kwargs): pass
def graphicsSettingsNeedRestart(*args, **kwargs): pass
def graphicsSettingsStatus(*args, **kwargs): pass
def hangarDestroyed(*args, **kwargs): pass
def hangarLoaded(*args, **kwargs): pass
def hasPendingGraphicsSettings(*args, **kwargs): pass

class ime(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ime'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	candidates = property(lambda self: None)
	candidatesVertical = property(lambda self: None)
	candidatesVisible = property(lambda self: None)
	composition = property(lambda self: None)
	compositionAttr = property(lambda self: None)
	compositionCursorPosition = property(lambda self: None)
	currentlyVisible = property(lambda self: None)
	enabled = property(lambda self: None)
	language = property(lambda self: None)
	reading = property(lambda self: None)
	readingVertical = property(lambda self: None)
	readingVisible = property(lambda self: None)
	selectedCandidate = property(lambda self: None)
	state = property(lambda self: None)

def importantGraphicSettings(*args, **kwargs): pass
def isApplyHighQualityPossible(*args, **kwargs): pass
def isArrayDictDataInstance(*args, **kwargs): pass
def isClientSpace(*args, **kwargs): pass
def isCustomGraphicPreset(*args, **kwargs): pass
def isDRRAutoscalingEnabled(*args, **kwargs): pass
def isDRRAutoscalingPaused(*args, **kwargs): pass
def isDynamicDecalEnabled(*args, **kwargs): pass
def isEval(*args, **kwargs): pass
def isFixedDictDataInstance(*args, **kwargs): pass
def isForwardPipeline(*args, **kwargs): pass
def isKeyDown(*args, **kwargs): pass
def isNextTickPending(*args, **kwargs): pass
def isSSAOEnabled(*args, **kwargs): pass
def isShadowsEnabled(*args, **kwargs): pass
def isTesselationSupported(*args, **kwargs): pass
def isTripleBuffered(*args, **kwargs): pass
def isVideoVSync(*args, **kwargs): pass
def isWindowVisible(*args, **kwargs): pass
def keyToString(*args, **kwargs): pass
def leaveSpace(*args, **kwargs): pass
def listBorderlessResolutionsAllMonitors(*args, **kwargs): pass
def listVideoModes(*args, **kwargs): pass
def listVideoModesAllMonitors(*args, **kwargs): pass
def loadResourceListBG(*args, **kwargs): pass
def loadResourceListFG(*args, **kwargs): pass
def lobbyStarted(*args, **kwargs): pass
def localeInfo(*args, **kwargs): pass
def logCritical(*args, **kwargs): pass
def logDebug(*args, **kwargs): pass
def logError(*args, **kwargs): pass
def logHack(*args, **kwargs): pass
def logInfo(*args, **kwargs): pass
def logNotice(*args, **kwargs): pass
def logTrace(*args, **kwargs): pass
def logWarning(*args, **kwargs): pass
def loginEntered(*args, **kwargs): pass
def makeScreenshotMarkInReplay(*args, **kwargs): pass
def makeWorldMatrix(*args, **kwargs): pass
def mapVirtualKey(*args, **kwargs): pass
def markerHelperScale(*args, **kwargs): pass
def memUsed(*args, **kwargs): pass
def memoryDebug(*args, **kwargs): pass
def models(*args, **kwargs): pass
def notify(*args, **kwargs): pass
def notifyBattleEndTime(*args, **kwargs): pass
def notifyBattleTime(*args, **kwargs): pass
def notifySpaceChange(*args, **kwargs): pass
def objectLod(*args, **kwargs): pass
def onInterfaceScaleChanged(*args, **kwargs): pass
def overloadBorders(*args, **kwargs): pass
def overrideGraphicsSetting(*args, **kwargs): pass
def pauseDRRAutoscaling(*args, **kwargs): pass
platform = u'windows'
def playMovie(*args, **kwargs): pass
def player(*args, **kwargs): pass
def playerDead(*args, **kwargs): pass
def printMainLoopTasksOrder(*args, **kwargs): pass
def probe(*args, **kwargs): pass
def projection(*args, **kwargs): pass
protocolVersion = u'17.1.0 (5)'
def purgeUrlRequestCache(*args, **kwargs): pass
def quit(*args, **kwargs): pass
def registerShadowCaster(*args, **kwargs): pass
def registerTextureStreamingViewpoint(*args, **kwargs): pass
def reinitLoggers(*args, **kwargs): pass
def reinitVideoSound(*args, **kwargs): pass
def releaseSpace(*args, **kwargs): pass
def removeAllIdleCallbacks(*args, **kwargs): pass
def removeCameraCollider(*args, **kwargs): pass
def resetEntityManager(*args, **kwargs): pass
def resetGraphicsSettingsStatus(*args, **kwargs): pass
def resetPlayerTargetFrom(*args, **kwargs): pass
def resetSettingsUsingDefault(*args, **kwargs): pass
def resizeWindow(*args, **kwargs): pass
def restartGame(*args, **kwargs): pass
def saveAllocationStatsToFile(*args, **kwargs): pass
def saveAllocationsToCacheGrindFile(*args, **kwargs): pass
def saveAllocationsToFile(*args, **kwargs): pass
def saveMemoryUsagePerTexture(*args, **kwargs): pass
def savePreferences(*args, **kwargs): pass
def screenHeight(*args, **kwargs): pass
def screenShot(*args, **kwargs): pass
def screenSize(*args, **kwargs): pass
def screenWidth(*args, **kwargs): pass
def server(*args, **kwargs): pass
serverDiscovery = ServerDiscovery()
def serverTime(*args, **kwargs): pass
def setActiveMonitorIndex(*args, **kwargs): pass
def setBorderlessFixedSize(*args, **kwargs): pass
def setBorderlessFullscreen(*args, **kwargs): pass
def setBorderlessParametersDirect(*args, **kwargs): pass
def setBorderlessUnconstrained(*args, **kwargs): pass
def setBorderlessWorkAreaMaximized(*args, **kwargs): pass
def setColorBCSSetup(*args, **kwargs): pass
def setColorBrightness(*args, **kwargs): pass
def setColorContrast(*args, **kwargs): pass
def setColorGradingStrength(*args, **kwargs): pass
def setColorSaturation(*args, **kwargs): pass
def setCursor(*args, **kwargs): pass
def setDRRScale(*args, **kwargs): pass
def setDamageStickerCriticalAngle(*args, **kwargs): pass
def setEdgeDrawerImpenetratableZoneOverlay(*args, **kwargs): pass
def setEdgeDrawerPenetratableZoneOverlay(*args, **kwargs): pass
def setEdgeDrawerRenderMode(*args, **kwargs): pass
def setFinalFlushURLRequestsTimeout(*args, **kwargs): pass
def setGammaCorrection(*args, **kwargs): pass
def setGraphicPresetByIndex(*args, **kwargs): pass
def setGraphicPresetByName(*args, **kwargs): pass
def setGraphicsSetting(*args, **kwargs): pass
def setIsImpassableZoneEnabled(*args, **kwargs): pass
def setMinLodBiasForTanks(*args, **kwargs): pass
def setPlayerTargetTo(*args, **kwargs): pass
def setSpeedTreeCollisionBody(*args, **kwargs): pass
def setTextureMinMip(*args, **kwargs): pass
def setTextureStreamingMode(*args, **kwargs): pass
def setTripleBuffering(*args, **kwargs): pass
def setVideoVSync(*args, **kwargs): pass
def setWatcher(*args, **kwargs): pass
def sinkKeyEvents(*args, **kwargs): pass
def solvePow(*args, **kwargs): pass
def spaceLoadStatus(*args, **kwargs): pass
def spaceTimeOfDay(*args, **kwargs): pass

class spaces(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __len__(self, *args, **kwargs): pass
	__module__ = 'BigWorld'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'spaces'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def get(self, *args, **kwargs): pass
	def has_key(self, *args, **kwargs): pass
	def items(self, *args, **kwargs): pass
	def keys(self, *args, **kwargs): pass
	def values(self, *args, **kwargs): pass

spaces = spaces()
def startBenchmarkTool(*args, **kwargs): pass
def statLagDetected(*args, **kwargs): pass
def statPing(*args, **kwargs): pass
def stime(*args, **kwargs): pass
def stopBenchmarkTool(*args, **kwargs): pass
def stopLoadResourceListBGTask(*args, **kwargs): pass
def stringToKey(*args, **kwargs): pass
target = PyTarget()
def time(*args, **kwargs): pass
def timeExact(*args, **kwargs): pass
def timeOfDay(*args, **kwargs): pass
def trackPhysicsQuality(*args, **kwargs): pass
def uniprofRegionEnter(*args, **kwargs): pass
def uniprofRegionExit(*args, **kwargs): pass
def uniprofSceneStart(*args, **kwargs): pass
def unregisterShadowCaster(*args, **kwargs): pass
def updateCurrentPresetIndex(*args, **kwargs): pass
def updateTerrainBorders(*args, **kwargs): pass
userDataObjects = {}
def videoModeIndex(*args, **kwargs): pass
def virtualTextureRenderComplete(*args, **kwargs): pass
def wgAddEdgeDetectCompoundModel(*args, **kwargs): pass
def wgAddEdgeDetectDynamicModel(*args, **kwargs): pass
def wgAddEdgeDetectEntity(*args, **kwargs): pass
def wgAddIgnoredCollisionEntity(*args, **kwargs): pass
def wgDelEdgeDetectCompoundModel(*args, **kwargs): pass
def wgDelEdgeDetectDynamicModel(*args, **kwargs): pass
def wgDelEdgeDetectEntity(*args, **kwargs): pass
def wgDelIgnoredCollisionEntity(*args, **kwargs): pass
def wgGetBenchmarkLocations(*args, **kwargs): pass
def wgSetEdgeDetectEdgeColor(*args, **kwargs): pass
def wgSetEdgeDetectPatternColors(*args, **kwargs): pass
def wgSetEdgeDetectSolidColors(*args, **kwargs): pass
def wg_addDecal(*args, **kwargs): pass
def wg_addDecalGroup(*args, **kwargs): pass
def wg_addMatkindScaleU(*args, **kwargs): pass
def wg_addScaleformTexture(*args, **kwargs): pass
def wg_addTempScaleformTexture(*args, **kwargs): pass
def wg_addWaterRipples(*args, **kwargs): pass
def wg_alloc(*args, **kwargs): pass
def wg_applyOverlayToModel(*args, **kwargs): pass
def wg_binoculars(*args, **kwargs): pass
def wg_bringWindowToForeground(*args, **kwargs): pass
def wg_calcGunPitchLimits(*args, **kwargs): pass
def wg_changeStringCasing(*args, **kwargs): pass
def wg_checkAnyParticlesExist(*args, **kwargs): pass
def wg_checkDestructibleIsBush(*args, **kwargs): pass
def wg_clearAllScaleformTextures(*args, **kwargs): pass
def wg_clearCrashedState(*args, **kwargs): pass
def wg_clearDecals(*args, **kwargs): pass
def wg_clearTextureReuseList(*args, **kwargs): pass
def wg_collectScaleformTextures(*args, **kwargs): pass
def wg_collideDynamic(*args, **kwargs): pass
def wg_collideDynamicStatic(*args, **kwargs): pass
def wg_collideDynamics(*args, **kwargs): pass
def wg_collideSegment(*args, **kwargs): pass
def wg_collideWater(*args, **kwargs): pass
def wg_computeProjectileTrajectory(*args, **kwargs): pass
def wg_copyToClipboard(*args, **kwargs): pass
def wg_cpdata(*args, **kwargs): pass
def wg_cpsalt(*args, **kwargs): pass
def wg_crash(*args, **kwargs): pass
def wg_createSplineTrack(*args, **kwargs): pass
def wg_decalTextureIndex(*args, **kwargs): pass
wg_defaultFlagEmblemCoords = (0, 0.1, 0.5, 0.9)
wg_defaultFlagEmblemPath = u'system/maps/wg_emblem.dds'
def wg_destroyFallAtom(*args, **kwargs): pass
def wg_destroyFragile(*args, **kwargs): pass
def wg_destroyModule(*args, **kwargs): pass
def wg_disableSpecialFPSMode(*args, **kwargs): pass
def wg_dumpScaleformMemoryReport(*args, **kwargs): pass
def wg_enableGUIBackground(*args, **kwargs): pass
def wg_enableInputEvents(*args, **kwargs): pass
def wg_enableKeyboardEvents(*args, **kwargs): pass
def wg_enableMouseEvents(*args, **kwargs): pass
def wg_enableTreeHiding(*args, **kwargs): pass
def wg_eraseScaleformResFromCache(*args, **kwargs): pass
def wg_eraseScaleformTexture(*args, **kwargs): pass
def wg_firstDayOfWeek(*args, **kwargs): pass
def wg_free(*args, **kwargs): pass
def wg_getCappedShotTargetInfos(*args, **kwargs): pass
def wg_getChunkDestrFilenames(*args, **kwargs): pass
def wg_getChunkMatrix(*args, **kwargs): pass
def wg_getChunkModelFashion(*args, **kwargs): pass
def wg_getClientStatistics(*args, **kwargs): pass
def wg_getCurrentResolution(*args, **kwargs): pass
def wg_getDestructibleEffectCategory(*args, **kwargs): pass
def wg_getDestructibleEffectName(*args, **kwargs): pass
def wg_getDestructibleEffectScale(*args, **kwargs): pass
def wg_getDestructibleEffectsTintColor(*args, **kwargs): pass
def wg_getDestructibleFallPitchConstr(*args, **kwargs): pass
def wg_getDestructibleFilename(*args, **kwargs): pass
def wg_getDestructibleHeight(*args, **kwargs): pass
def wg_getDestructibleLifetimeEffectChance(*args, **kwargs): pass
def wg_getDestructibleMatrix(*args, **kwargs): pass
def wg_getFallingParams(*args, **kwargs): pass
def wg_getFrameTimestamp(*args, **kwargs): pass
def wg_getHangarStatistics(*args, **kwargs): pass
def wg_getHardPointMatrix(*args, **kwargs): pass
def wg_getLangCode(*args, **kwargs): pass
def wg_getMatInfoNearPoint(*args, **kwargs): pass
def wg_getMathInfoUnderPoint(*args, **kwargs): pass
def wg_getMaxBorderlessResolution(*args, **kwargs): pass
def wg_getMaxWindowedResolution(*args, **kwargs): pass
def wg_getMonitorNames(*args, **kwargs): pass
def wg_getNMHardPointMatrix(*args, **kwargs): pass
def wg_getNativeScreenResoulution(*args, **kwargs): pass
def wg_getPreferencesFilePath(*args, **kwargs): pass
def wg_getProductVersion(*args, **kwargs): pass
def wg_getShotAngles(*args, **kwargs): pass
def wg_getShotAnglesNew(*args, **kwargs): pass
def wg_getSpaceBounds(*args, **kwargs): pass
def wg_getSpaceItemsVisibilityMask(*args, **kwargs): pass
def wg_getTimePerFrame(*args, **kwargs): pass
def wg_havokExplosion(*args, **kwargs): pass
def wg_havokSetSniperMode(*args, **kwargs): pass
def wg_havokWipe(*args, **kwargs): pass
def wg_initCustomSettings(*args, **kwargs): pass
def wg_isCapsLockOn(*args, **kwargs): pass
def wg_isDestrCanBeActivated(*args, **kwargs): pass
def wg_isHavokActive(*args, **kwargs): pass
def wg_isNumLockOn(*args, **kwargs): pass
def wg_isSSE2Supported(*args, **kwargs): pass
def wg_isScrollLockOn(*args, **kwargs): pass
def wg_isSniperModeSwingingEnabled(*args, **kwargs): pass
def wg_isVehicleDustEnabled(*args, **kwargs): pass
def wg_openWebBrowser(*args, **kwargs): pass
def wg_precacheScaleformResource(*args, **kwargs): pass
def wg_preferencesExistedAtStartup(*args, **kwargs): pass
def wg_prefetchSpaceZip(*args, **kwargs): pass
def wg_printScaleformCacheStatictics(*args, **kwargs): pass
def wg_quitAndStartLauncher(*args, **kwargs): pass
def wg_registerDamageSticker(*args, **kwargs): pass
def wg_resolveFileName(*args, **kwargs): pass
def wg_restoreDestructibles(*args, **kwargs): pass
def wg_saveWatchers(*args, **kwargs): pass
def wg_setAdapterOrdinalNotifyCallback(*args, **kwargs): pass
def wg_setAimingParam(*args, **kwargs): pass
def wg_setChunkModelFashion(*args, **kwargs): pass
def wg_setDestructibleActive(*args, **kwargs): pass
def wg_setDestructibleMatrix(*args, **kwargs): pass
def wg_setFlagColor(*args, **kwargs): pass
def wg_setFlagEmblem(*args, **kwargs): pass
def wg_setGUIBackground(*args, **kwargs): pass
def wg_setHourOfDay(*args, **kwargs): pass
def wg_setMaxFrameRate(*args, **kwargs): pass
def wg_setObservableMProv(*args, **kwargs): pass
def wg_setPyModelTexture(*args, **kwargs): pass
def wg_setRedefineKeysMode(*args, **kwargs): pass
def wg_setReducedFpsMode(*args, **kwargs): pass
def wg_setScreenshotNotifyCallback(*args, **kwargs): pass
def wg_setSpaceItemsVisibilityMask(*args, **kwargs): pass
def wg_setSpecialFPSMode(*args, **kwargs): pass
def wg_setTreeHidingRadius(*args, **kwargs): pass
def wg_setWaterFreqX(*args, **kwargs): pass
def wg_setWaterFreqZ(*args, **kwargs): pass
def wg_setWaterTexScale(*args, **kwargs): pass
def wg_setupGroundMaterialsMap(*args, **kwargs): pass
def wg_setupMaterialHardness(*args, **kwargs): pass
def wg_setupPhysicsParam(*args, **kwargs): pass
def wg_simulateProjectileTrajectory(*args, **kwargs): pass
def wg_solveDestructibleFallPitch(*args, **kwargs): pass
def wg_subscribeToReadPreferences(*args, **kwargs): pass
def wg_subscribeToSavePreferences(*args, **kwargs): pass
def wg_traceTextureIndex(*args, **kwargs): pass
def wg_trajectory_drawer(*args, **kwargs): pass
def wg_translateToScaleformKeyCode(*args, **kwargs): pass
def wg_ucpdata(*args, **kwargs): pass
def wg_unsubAllSavePreferences(*args, **kwargs): pass
def wg_updateColorGrading(*args, **kwargs): pass
def wg_writeToStdOut(*args, **kwargs): pass
def windowSize(*args, **kwargs): pass
def worldDrawEnabled(*args, **kwargs): pass