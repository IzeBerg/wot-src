# Stubs Generator
# import Particle
# <module 'Particle' (built-in)>


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


class Actions(pybind11_object):
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
	__module__ = 'Particle'
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
	__qualname__ = 'Actions'
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


class ParticleSystem(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'Particle'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ParticleSystem'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def action(self, *args, **kwargs): pass
	actions = property(lambda self: None)
	def addAction(self, *args, **kwargs): pass
	attached = property(lambda self: None)
	capacity = property(lambda self: None)
	castsShadow = property(lambda self: None)
	def clear(self, *args, **kwargs): pass
	drawOrder = property(lambda self: None)
	def duration(self, *args, **kwargs): pass
	explicitDirection = property(lambda self: None)
	explicitPosition = property(lambda self: None)
	fixedFrameRate = property(lambda self: None)
	def force(self, *args, **kwargs): pass
	inWorld = property(lambda self: None)
	def load(self, *args, **kwargs): pass
	matrix = property(lambda self: None)
	maxLod = property(lambda self: None)
	def removeAction(self, *args, **kwargs): pass
	def render(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	scale = property(lambda self: None)
	def size(self, *args, **kwargs): pass
	def update(self, *args, **kwargs): pass
	windFactor = property(lambda self: None)


class PyDirectParticleAttachment(PyAttachment):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'Particle'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyDirectParticleAttachment'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
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

__doc__ = None
__name__ = 'Particle'
__package__ = None