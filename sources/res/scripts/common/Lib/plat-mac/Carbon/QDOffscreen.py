

def FOUR_CHAR_CODE(x):
    return x


pixPurgeBit = 0
noNewDeviceBit = 1
useTempMemBit = 2
keepLocalBit = 3
useDistantHdwrMemBit = 4
useLocalHdwrMemBit = 5
pixelsPurgeableBit = 6
pixelsLockedBit = 7
mapPixBit = 16
newDepthBit = 17
alignPixBit = 18
newRowBytesBit = 19
reallocPixBit = 20
clipPixBit = 28
stretchPixBit = 29
ditherPixBit = 30
gwFlagErrBit = 31
pixPurge = 1 << pixPurgeBit
noNewDevice = 1 << noNewDeviceBit
useTempMem = 1 << useTempMemBit
keepLocal = 1 << keepLocalBit
useDistantHdwrMem = 1 << useDistantHdwrMemBit
useLocalHdwrMem = 1 << useLocalHdwrMemBit
pixelsPurgeable = 1 << pixelsPurgeableBit
pixelsLocked = 1 << pixelsLockedBit
kAllocDirectDrawSurface = 16384
mapPix = 1 << mapPixBit
newDepth = 1 << newDepthBit
alignPix = 1 << alignPixBit
newRowBytes = 1 << newRowBytesBit
reallocPix = 1 << reallocPixBit
clipPix = 1 << clipPixBit
stretchPix = 1 << stretchPixBit
ditherPix = 1 << ditherPixBit
gwFlagErr = 1 << gwFlagErrBit
deviceIsIndirect = 1
deviceNeedsLock = 2
deviceIsStatic = 4
deviceIsExternalBuffer = 8
deviceIsDDSurface = 16
deviceIsDCISurface = 32
deviceIsGDISurface = 64
deviceIsAScreen = 128
deviceIsOverlaySurface = 256