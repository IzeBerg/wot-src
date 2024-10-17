# Stubs Generator
# import DamageComponents
# <module 'DamageComponents' (built-in)>

ABSOLUTE_VALUE = DamageType.ABSOLUTE_VALUE

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


class DamageOnCollisionComponent(PyComponentWrapperBase):
	def __cmp__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'DamageComponents'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DamageOnCollisionComponent'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	cameraName = property(lambda self: None)
	def clear(self, *args, **kwargs): pass
	def destroy(self, *args, **kwargs): pass
	destroyingTime = property(lambda self: None)
	def id(self, *args, **kwargs): pass
	isDestroying = property(lambda self: None)
	isOnBodyCollision = property(lambda self: None)
	isOnSimulationObjectCollision = property(lambda self: None)
	isOnVehicleCollision = property(lambda self: None)
	killResolveType = property(lambda self: None)
	killSpeed = property(lambda self: None)
	def shouldDestroy(self, *args, **kwargs): pass
	subscriptionTime = property(lambda self: None)
	def valid(self, *args, **kwargs): pass


class DamageType(pybind11_object):
	ABSOLUTE_VALUE = DamageType.ABSOLUTE_VALUE
	PERCENTS = DamageType.PERCENTS
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  PERCENTS\n\n  ABSOLUTE_VALUE'
	__entries = {u'PERCENTS': (DamageType.PERCENTS, None), u'ABSOLUTE_VALUE': (DamageType.ABSOLUTE_VALUE, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'PERCENTS': DamageType.PERCENTS, u'ABSOLUTE_VALUE': DamageType.ABSOLUTE_VALUE}
	__module__ = 'DamageComponents'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DamageType'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)


class DamageZoneComponent(PyComponentWrapperBase):
	def __cmp__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'DamageComponents'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DamageZoneComponent'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def clear(self, *args, **kwargs): pass
	damagePercentRandomization = property(lambda self: None)
	damageType = property(lambda self: None)
	damageValue = property(lambda self: None)
	def destroy(self, *args, **kwargs): pass
	enterReactionID = property(lambda self: None)
	exitReactionID = property(lambda self: None)
	def id(self, *args, **kwargs): pass
	period = property(lambda self: None)
	def valid(self, *args, **kwargs): pass
	zoneType = property(lambda self: None)


class DamageZoneType(pybind11_object):
	FIRE_DAMAGE_ZONE = DamageZoneType.FIRE_DAMAGE_ZONE
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  FIRE_DAMAGE_ZONE'
	__entries = {u'FIRE_DAMAGE_ZONE': (DamageZoneType.FIRE_DAMAGE_ZONE, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'FIRE_DAMAGE_ZONE': DamageZoneType.FIRE_DAMAGE_ZONE}
	__module__ = 'DamageComponents'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DamageZoneType'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)

FIRE_DAMAGE_ZONE = DamageZoneType.FIRE_DAMAGE_ZONE

class KillResolveType(pybind11_object):
	FREEZE = KillResolveType.FREEZE
	NONE = KillResolveType.NONE
	PUSH = KillResolveType.PUSH
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  PUSH\n\n  NONE\n\n  FREEZE'
	__entries = {u'PUSH': (KillResolveType.PUSH, None), u'NONE': (KillResolveType.NONE, None), u'FREEZE': (KillResolveType.FREEZE, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'PUSH': KillResolveType.PUSH, u'NONE': KillResolveType.NONE, u'FREEZE': KillResolveType.FREEZE}
	__module__ = 'DamageComponents'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'KillResolveType'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)

PERCENTS = DamageType.PERCENTS
__doc__ = None
__name__ = 'DamageComponents'
__package__ = None