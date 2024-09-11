# Stubs Generator
# import Pixie
# <module 'Pixie' (built-in)>

def InfluxInvalidateParticlesCache(*args, **kwargs): pass

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


class PyParticleSystemAction(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'Particle'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyParticleSystemAction'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	delay = property(lambda self: None)
	minimumAge = property(lambda self: None)
	typeID = property(lambda self: None)


class InfluxPSA(PyParticleSystemAction):
	def MultRate(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Pixie'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'InfluxPSA'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	delay = property(lambda self: None)
	minimumAge = property(lambda self: None)
	typeID = property(lambda self: None)


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


class MetaParticleSystem(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Pixie'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'MetaParticleSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def addSystem(self, *args, **kwargs): pass
	def applyModifiers(self, *args, **kwargs): pass
	attached = property(lambda self: None)
	castsShadow = property(lambda self: None)
	def clear(self, *args, **kwargs): pass
	def clone(self, *args, **kwargs): pass
	drawOrder = property(lambda self: None)
	def duration(self, *args, **kwargs): pass
	def force(self, *args, **kwargs): pass
	inWorld = property(lambda self: None)
	def load(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	def nSystems(self, *args, **kwargs): pass
	def particlesCount(self, *args, **kwargs): pass
	def removeAllSystems(self, *args, **kwargs): pass
	def removeSystem(self, *args, **kwargs): pass
	def render(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	scale = property(lambda self: None)
	def system(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass

__doc__ = None
__name__ = 'Pixie'
__package__ = None
def create(*args, **kwargs): pass
def createBG(*args, **kwargs): pass
def prerequisites(*args, **kwargs): pass