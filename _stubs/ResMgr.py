# Stubs Generator
# import ResMgr
# <module 'ResMgr' (built-in)>


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


class DataSection(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(self, *args, **kwargs): pass
	def __getitem__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __len__(self, *args, **kwargs): pass
	__module__ = 'ResMgr'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DataSection'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	asBinary = property(lambda self: None)
	asBlob = property(lambda self: None)
	asBool = property(lambda self: None)
	asFloat = property(lambda self: None)
	asInt = property(lambda self: None)
	asInt64 = property(lambda self: None)
	asMatrix = property(lambda self: None)
	asString = property(lambda self: None)
	asVector2 = property(lambda self: None)
	asVector3 = property(lambda self: None)
	asVector4 = property(lambda self: None)
	asWideString = property(lambda self: None)
	def child(self, *args, **kwargs): pass
	def childName(self, *args, **kwargs): pass
	def cleanName(self, *args, **kwargs): pass
	def copy(self, *args, **kwargs): pass
	def copyToZip(self, *args, **kwargs): pass
	def createSection(self, *args, **kwargs): pass
	def createSectionFromString(self, *args, **kwargs): pass
	def deleteSection(self, *args, **kwargs): pass
	def getFirstIndex(self, *args, **kwargs): pass
	def has_key(self, *args, **kwargs): pass
	def insertSection(self, *args, **kwargs): pass
	isAttribute = property(lambda self: None)
	def isNameClean(self, *args, **kwargs): pass
	def items(self, *args, **kwargs): pass
	def keys(self, *args, **kwargs): pass
	name = property(lambda self: None)
	def parentSection(self, *args, **kwargs): pass
	def readBlob(self, *args, **kwargs): pass
	def readBool(self, *args, **kwargs): pass
	def readFloat(self, *args, **kwargs): pass
	def readFloats(self, *args, **kwargs): pass
	def readInt(self, *args, **kwargs): pass
	def readInt64(self, *args, **kwargs): pass
	def readInts(self, *args, **kwargs): pass
	def readMatrix(self, *args, **kwargs): pass
	def readString(self, *args, **kwargs): pass
	def readStrings(self, *args, **kwargs): pass
	def readVector2(self, *args, **kwargs): pass
	def readVector2s(self, *args, **kwargs): pass
	def readVector3(self, *args, **kwargs): pass
	def readVector3s(self, *args, **kwargs): pass
	def readVector4(self, *args, **kwargs): pass
	def readVector4s(self, *args, **kwargs): pass
	def readWideString(self, *args, **kwargs): pass
	def readWideStrings(self, *args, **kwargs): pass
	references = property(lambda self: None)
	def rootSection(self, *args, **kwargs): pass
	def save(self, *args, **kwargs): pass
	def values(self, *args, **kwargs): pass
	def write(self, *args, **kwargs): pass
	def writeBlob(self, *args, **kwargs): pass
	def writeBool(self, *args, **kwargs): pass
	def writeFloat(self, *args, **kwargs): pass
	def writeFloats(self, *args, **kwargs): pass
	def writeInt(self, *args, **kwargs): pass
	def writeInt64(self, *args, **kwargs): pass
	def writeInts(self, *args, **kwargs): pass
	def writeMatrix(self, *args, **kwargs): pass
	def writeString(self, *args, **kwargs): pass
	def writeStrings(self, *args, **kwargs): pass
	def writeVector2(self, *args, **kwargs): pass
	def writeVector2s(self, *args, **kwargs): pass
	def writeVector3(self, *args, **kwargs): pass
	def writeVector3s(self, *args, **kwargs): pass
	def writeVector4(self, *args, **kwargs): pass
	def writeWideString(self, *args, **kwargs): pass
	def writeWideStrings(self, *args, **kwargs): pass
	def writewriteVector4sBlob(self, *args, **kwargs): pass


class DistributionLevel(pybind11_object):
	DistributionLevel::CEF = DistributionLevel.DistributionLevel::CEF
	DistributionLevel::DEFAULT = DistributionLevel.DistributionLevel::DEFAULT
	DistributionLevel::HD_TEXTURES = DistributionLevel.DistributionLevel::HD_TEXTURES
	DistributionLevel::INCOMPLETE = DistributionLevel.DistributionLevel::INCOMPLETE
	DistributionLevel::MAX_LEVEL = DistributionLevel.DistributionLevel::MAX_LEVEL
	DistributionLevel::SANDBOX = DistributionLevel.DistributionLevel::SANDBOX
	DistributionLevel::SD_TEXTURES = DistributionLevel.DistributionLevel::SD_TEXTURES
	DistributionLevel::TUTORIAL = DistributionLevel.DistributionLevel::TUTORIAL
	def __delattr__(*args, **kwargs): pass
	__doc__ = u'Members:\n\n  DistributionLevel::DEFAULT\n\n  DistributionLevel::TUTORIAL\n\n  DistributionLevel::SANDBOX\n\n  DistributionLevel::HD_TEXTURES\n\n  DistributionLevel::CEF\n\n  DistributionLevel::MAX_LEVEL\n\n  DistributionLevel::SD_TEXTURES\n\n  DistributionLevel::INCOMPLETE'
	__entries = {u'DistributionLevel::DEFAULT': (DistributionLevel.DistributionLevel::DEFAULT, None), u'DistributionLevel::TUTORIAL': (DistributionLevel.DistributionLevel::TUTORIAL, None), u'DistributionLevel::SANDBOX': (DistributionLevel.DistributionLevel::SANDBOX, None), u'DistributionLevel::HD_TEXTURES': (DistributionLevel.DistributionLevel::HD_TEXTURES, None), u'DistributionLevel::CEF': (DistributionLevel.DistributionLevel::CEF, None), u'DistributionLevel::MAX_LEVEL': (DistributionLevel.DistributionLevel::MAX_LEVEL, None), u'DistributionLevel::SD_TEXTURES': (DistributionLevel.DistributionLevel::SD_TEXTURES, None), u'DistributionLevel::INCOMPLETE': (DistributionLevel.DistributionLevel::INCOMPLETE, None)}
	def __eq__(self, *args, **kwargs): pass
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getstate__(self, *args, **kwargs): pass
	def __hash__(self, *args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __int__(self, *args, **kwargs): pass
	def __long__(self, *args, **kwargs): pass
	__members__ = {u'DistributionLevel::DEFAULT': DistributionLevel.DistributionLevel::DEFAULT, u'DistributionLevel::TUTORIAL': DistributionLevel.DistributionLevel::TUTORIAL, u'DistributionLevel::SANDBOX': DistributionLevel.DistributionLevel::SANDBOX, u'DistributionLevel::MAX_LEVEL': DistributionLevel.DistributionLevel::MAX_LEVEL, u'DistributionLevel::CEF': DistributionLevel.DistributionLevel::CEF, u'DistributionLevel::HD_TEXTURES': DistributionLevel.DistributionLevel::HD_TEXTURES, u'DistributionLevel::SD_TEXTURES': DistributionLevel.DistributionLevel::SD_TEXTURES, u'DistributionLevel::INCOMPLETE': DistributionLevel.DistributionLevel::INCOMPLETE}
	__module__ = 'ResMgr'
	def __ne__(self, *args, **kwargs): pass
	def __new__(*args, **kwargs): pass
	__qualname__ = 'DistributionLevel'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(self, *args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __setstate__(self, *args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	name = property(lambda self: None)

DistributionLevel::CEF = DistributionLevel.DistributionLevel::CEF
DistributionLevel::DEFAULT = DistributionLevel.DistributionLevel::DEFAULT
DistributionLevel::HD_TEXTURES = DistributionLevel.DistributionLevel::HD_TEXTURES
DistributionLevel::INCOMPLETE = DistributionLevel.DistributionLevel::INCOMPLETE
DistributionLevel::MAX_LEVEL = DistributionLevel.DistributionLevel::MAX_LEVEL
DistributionLevel::SANDBOX = DistributionLevel.DistributionLevel::SANDBOX
DistributionLevel::SD_TEXTURES = DistributionLevel.DistributionLevel::SD_TEXTURES
DistributionLevel::TUTORIAL = DistributionLevel.DistributionLevel::TUTORIAL

class ResMgrImportHook(pybind11_object):
	def __call__(self, *args, **kwargs): pass
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'ResMgr'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ResMgrImportHook'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def getImporter(self, *args, **kwargs): pass


class ResMgrImportLoader(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'ResMgr'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ResMgrImportLoader'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def find_module(self, *args, **kwargs): pass
	def load_module(self, *args, **kwargs): pass
	path = property(lambda self: None)


class ResTblStruct(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = 'ResMgr'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ResTblStruct'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def get(self, *args, **kwargs): pass


class ResourceTable(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __getitem__(self, *args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(self, *args, **kwargs): pass
	def __len__(self, *args, **kwargs): pass
	__module__ = 'ResMgr'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'ResourceTable'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def at(self, *args, **kwargs): pass
	index = property(lambda self: None)
	def indexOfKey(self, *args, **kwargs): pass
	key = property(lambda self: None)
	def keyOfIndex(self, *args, **kwargs): pass
	def link(self, *args, **kwargs): pass
	def sub(self, *args, **kwargs): pass
	def unlink(self, *args, **kwargs): pass
	value = property(lambda self: None)

__doc__ = None
__name__ = 'ResMgr'
__package__ = None
def activeContentType(*args, **kwargs): pass
def appDirectory(*args, **kwargs): pass
def getFilename(*args, **kwargs): pass
def isDir(*args, **kwargs): pass
def isFile(*args, **kwargs): pass
def localise(*args, **kwargs): pass
def openSection(*args, **kwargs): pass
def purge(*args, **kwargs): pass
def readDirectory(*args, **kwargs): pass
def resolveToAbsolutePath(*args, **kwargs): pass
def save(*args, **kwargs): pass