# Stubs Generator
# import _WWISE
# <module '_WWISE' (built-in)>


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


class PySound(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = '_WWISE'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'PySound'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	isPlaying = property(lambda self: None)
	matrixProvider = property(lambda self: None)
	name = property(lambda self: None)
	def play(self, *args, **kwargs): pass
	def releaseMatrix(self, *args, **kwargs): pass
	def restart(self, *args, **kwargs): pass
	def setCallback(self, *args, **kwargs): pass
	def setDirection(self, *args, **kwargs): pass
	def setPosition(self, *args, **kwargs): pass
	def setRTPC(self, *args, **kwargs): pass
	def setSwitch(self, *args, **kwargs): pass
	def stop(self, *args, **kwargs): pass
	def unlink(self, *args, **kwargs): pass
	volume = property(lambda self: None)


class RTPCValue(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = '_WWISE'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'RTPCValue'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def set(self, *args, **kwargs): pass


class SoundObject(pybind11_object):
	def __delattr__(*args, **kwargs): pass
	__doc__ = None
	def __format__(*args, **kwargs): pass
	def __getattribute__(*args, **kwargs): pass
	def __hash__(*args, **kwargs): pass
	def __init__(*args, **kwargs): pass
	__module__ = '_WWISE'
	def __new__(*args, **kwargs): pass
	__qualname__ = 'SoundObject'
	def __reduce__(*args, **kwargs): pass
	def __reduce_ex__(*args, **kwargs): pass
	def __repr__(*args, **kwargs): pass
	def __setattr__(*args, **kwargs): pass
	def __sizeof__(*args, **kwargs): pass
	def __str__(*args, **kwargs): pass
	def __subclasshook__(*args, **kwargs): pass
	def isPlaying(self, *args, **kwargs): pass
	matrixProvider = property(lambda self: None)
	name = property(lambda self: None)
	def play(self, *args, **kwargs): pass
	def setDopplerEffect(self, *args, **kwargs): pass
	def setRTPC(self, *args, **kwargs): pass
	def setSwitch(self, *args, **kwargs): pass
	def stop(self, *args, **kwargs): pass
	def stopAll(self, *args, **kwargs): pass
	def stopDopplerEffect(self, *args, **kwargs): pass
	volume = property(lambda self: None)

def WG_isMSR(*args, **kwargs): pass
def WG_lightSoundRemove(*args, **kwargs): pass
def WG_loadLogin(*args, **kwargs): pass
def WW_addMarkerListener(*args, **kwargs): pass
def WW_eventGlobal(*args, **kwargs): pass
def WW_eventGlobalPos(*args, **kwargs): pass
def WW_eventGlobalSync(*args, **kwargs): pass
def WW_getCameraOriented(*args, **kwargs): pass
def WW_getRTPCValue(*args, **kwargs): pass
def WW_getSound(*args, **kwargs): pass
def WW_getSoundCallback(*args, **kwargs): pass
def WW_getSoundObject(*args, **kwargs): pass
def WW_getSoundPos(*args, **kwargs): pass
def WW_getSystemSpeakersConfig(*args, **kwargs): pass
def WW_getUserSpeakersConfig(*args, **kwargs): pass
def WW_isInitialised(*args, **kwargs): pass
def WW_loadCustomSoundBanks(*args, **kwargs): pass
def WW_onMemoryCritical(*args, **kwargs): pass
def WW_playCameraOriented(*args, **kwargs): pass
def WW_prepareMP3(*args, **kwargs): pass
def WW_reinit(*args, **kwargs): pass
def WW_removeMarkerListener(*args, **kwargs): pass
def WW_setLowQuality(*args, **kwargs): pass
def WW_setMasterVolume(*args, **kwargs): pass
def WW_setRTCPGlobal(*args, **kwargs): pass
def WW_setRTPCBus(*args, **kwargs): pass
def WW_setRealm(*args, **kwargs): pass
def WW_setSoundSystem(*args, **kwargs): pass
def WW_setSpeakersConfig(*args, **kwargs): pass
def WW_setState(*args, **kwargs): pass
def WW_setSwitch(*args, **kwargs): pass
def WW_setUserSpeakersConfig(*args, **kwargs): pass
def WW_soundSystemInfo(*args, **kwargs): pass
def WW_startProfilerCapture(*args, **kwargs): pass
def WW_stopProfilerCapture(*args, **kwargs): pass
def WW_unloadCustomSoundBanks(*args, **kwargs): pass
def WWsetCameraShift(*args, **kwargs): pass
__doc__ = None
__name__ = '_WWISE'
__package__ = None
def activateRemapping(*args, **kwargs): pass
def createPlaybackPool(*args, **kwargs): pass
def deactivateRemapping(*args, **kwargs): pass
def playSound(*args, **kwargs): pass
def setLanguage(*args, **kwargs): pass