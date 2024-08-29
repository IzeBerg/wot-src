# Stubs Generator
# import CGF
# <module 'CGF' (built-in)>

CGF_COMPONENT_MARKER = u'__cgf_component__'
CGF_REPLICABLE_COMPONENT_MARKER = u'__cgf_replicable_component__'

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


class Clock(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Clock'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	frameTimeStamp = property(lambda self: None)
	gameDelta = property(lambda self: None)
	gameTime = property(lambda self: None)
	renderDelta = property(lambda self: None)
	renderTime = property(lambda self: None)
	serverTime = property(lambda self: None)


class ComponentLink(pybind11_object):
	def __call__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ComponentLink'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	gameObject = property(lambda self: None)


class ComponentManager(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ComponentManager'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	clock = property(lambda self: None)
	def getManager(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)

DEBUG_WORLD = -1023
DomainAll = DomainOption.DomainAll
DomainClient = DomainOption.DomainClient
DomainEditor = DomainOption.DomainEditor

class DomainOption(pybind11_object):
	DomainAll = DomainOption.DomainAll
	DomainClient = DomainOption.DomainClient
	DomainEditor = DomainOption.DomainEditor
	DomainServer = DomainOption.DomainServer
	LockDomain = DomainOption.LockDomain
	def __and__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  DomainServer\n\n  DomainEditor\n\n  DomainAll\n\n  DomainClient\n\n  LockDomain'
	__entries = {u'DomainServer': (DomainOption.DomainServer, None), u'DomainEditor': (DomainOption.DomainEditor, None), u'DomainAll': (DomainOption.DomainAll, None), u'DomainClient': (DomainOption.DomainClient, None), u'LockDomain': (DomainOption.LockDomain, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __ge__(self, *args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __gt__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __invert__(self, *args, **kwargs): pass
	def __le__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	def __lt__(self, *args, **kwargs): pass
	__members__ = {u'DomainServer': DomainOption.DomainServer, u'DomainEditor': DomainOption.DomainEditor, u'DomainAll': DomainOption.DomainAll, u'DomainClient': DomainOption.DomainClient, u'LockDomain': DomainOption.LockDomain}
	__module__ = 'CGF'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	def __or__(self, *args, **kwargs): pass
	__qualname__ = 'DomainOption'
	def __rand__(self, *args, **kwargs): pass
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __ror__(self, *args, **kwargs): pass
	def __rxor__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def __xor__(self, *args, **kwargs): pass
	name = property(lambda self: None)

DomainServer = DomainOption.DomainServer

class GameObject(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'GameObject'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def activate(self, *args, **kwargs): pass
	def addComponent(self, *args, **kwargs): pass
	def createComponent(self, *args, **kwargs): pass
	def deactivate(self, *args, **kwargs): pass
	def destroy(self, *args, **kwargs): pass
	def findComponentByType(self, *args, **kwargs): pass
	def getComponents(self, *args, **kwargs): pass
	id = property(lambda self: None)
	index = property(lambda self: None)
	def isActive(self, *args, **kwargs): pass
	def isValid(self, *args, **kwargs): pass
	name = property(lambda self: None)
	def removeComponent(self, *args, **kwargs): pass
	def removeComponentByType(self, *args, **kwargs): pass
	def setStatic(self, *args, **kwargs): pass
	spaceID = property(lambda self: None)
	def transferOwnershipToWorld(self, *args, **kwargs): pass


class HierarchyManager(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'HierarchyManager'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def findComponentsInHierarchy(self, *args, **kwargs): pass
	def findFirstNode(self, *args, **kwargs): pass
	def findNodes(self, *args, **kwargs): pass
	def getChildren(self, *args, **kwargs): pass
	def getChildrenIncludingInactive(self, *args, **kwargs): pass
	def getParent(self, *args, **kwargs): pass
	def getTopMostParent(self, *args, **kwargs): pass
	def hasChildren(self, *args, **kwargs): pass
	def hasParent(self, *args, **kwargs): pass
	roots = property(lambda self: None)

LockDomain = DomainOption.LockDomain

class No(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'No'
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


class PyManagerLink(pybind11_object):
	def __call__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyManagerLink'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class PyNativeEventWrapper(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PyNativeEventWrapper'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class Query(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __iter__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Query'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def empty(self, *args, **kwargs): pass
	def next(self, *args, **kwargs): pass
	def values(self, *args, **kwargs): pass


class QueryConfig(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'QueryConfig'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class Reaction(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'Reaction'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass


class World(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	__module__ = 'CGF'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'World'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	spaceID = property(lambda self: None)

__doc__ = None
__name__ = 'CGF'
__package__ = None
def addNetworkEntity(*args, **kwargs): pass
def cacheGameObjects(*args, **kwargs): pass
def calcTotalComponents(*args, **kwargs): pass
def calcTotalGameObjects(*args, **kwargs): pass
def changeHierarchy(*args, **kwargs): pass
def clearGameObjectsCache(*args, **kwargs): pass
def createDebugWorld(*args, **kwargs): pass
def createManager(*args, **kwargs): pass
def disableCompletely(*args, **kwargs): pass
def dumpCgfState(*args, **kwargs): pass
def dumpCgfWorldHierarchy(*args, **kwargs): pass
def dumpTickGraph(*args, **kwargs): pass
def enableCompletely(*args, **kwargs): pass
def gatherPrefabInfo(*args, **kwargs): pass
def getAllWorlds(*args, **kwargs): pass
def getManager(*args, **kwargs): pass
def hotReload(*args, **kwargs): pass
def isCgfEnabled(*args, **kwargs): pass
def listAllActiveComponents(*args, **kwargs): pass
def listAllActiveGameObjects(*args, **kwargs): pass
def listAllActivePureScriptComponents(*args, **kwargs): pass
def listAllEmbeddedComponentTypes(*args, **kwargs): pass
def loadComplexObjectDescriptor(*args, **kwargs): pass
def loadGameObject(*args, **kwargs): pass
def loadGameObjectIntoHierarchy(*args, **kwargs): pass
def loadGameObjectSection(*args, **kwargs): pass
def loadGameObjectsSpace(*args, **kwargs): pass
def registerComponent(*args, **kwargs): pass
def registerManager(*args, **kwargs): pass
def registerModulePath(*args, **kwargs): pass
def removeGameObject(*args, **kwargs): pass
def removeNetworkEntity(*args, **kwargs): pass
def unloadAllGameObjects(*args, **kwargs): pass