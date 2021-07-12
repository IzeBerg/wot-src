from bitstring import BitArray
from bit_coder import BitCoder

class Layout(object):
    __slots__ = ('rows', 'columns', 'stamps', '__iadd__', '__isub__', '__len__', 'asInt',
                 'fromInt', 'layoutData')
    LAYOUTS = dict(((16, 4), (15, 5), (14, 7), (10, 5), (12, 4), (9, 3), (8, 4), (6, 3), (4, 2)))
    filledCount = property(lambda self: self.layoutData.count(1))
    emptyCount = property(lambda self: self.layoutData.count(0))

    @classmethod
    def fromInt(cls, packedLayout=None, length=None):
        length = cls.__checkParams(packedLayout, length)
        return cls(0 if packedLayout is None else int(packedLayout), length)

    @classmethod
    def calcFilledfromInt(cls, packedLayout, length):
        cls.__checkParams(packedLayout, length)
        return cls.__numberOfSetBits(packedLayout & BitCoder.mask(length))

    @classmethod
    def calcEmptyfromInt(cls, packedLayout, length):
        return length - cls.calcFilledfromInt(packedLayout, length)

    def asInt(self):
        return (len(self) << 28) + (self.columns << 24) + (self.stamps.uint << 16) + self.layoutData.uint

    def __init__(self, intLayout, length):
        layoutDataLength = int(intLayout >> 28 or length)
        self.columns = intLayout >> 24 & 15 or self.LAYOUTS.get(layoutDataLength, layoutDataLength)
        self.rows = layoutDataLength / self.columns
        arrayData = BitArray(length=32, uint=intLayout)
        self.stamps = arrayData[8:16]
        self.layoutData = arrayData[-layoutDataLength:]

    def __iadd__(self, other):
        if type(other) not in (int, long):
            raise TypeError()
        layoutData = self.layoutData
        layoutDataLength = self.layoutData.length
        isInc = other > 0
        other = min(layoutDataLength, abs(other))
        for idx in xrange(layoutDataLength):
            if not other:
                break
            if isInc ^ layoutData[idx]:
                layoutData[idx] = isInc
                other -= 1

        return self

    def __isub__(self, other):
        return self.__iadd__(-other)

    def __len__(self):
        return self.layoutData.length

    def __setitem__(self, key, value):
        self.layoutData[key] = value

    def __getitem__(self, item):
        return self.layoutData[item]

    def __repr__(self):
        return bin(self.layoutData[-len(self)::].uint)

    @staticmethod
    def __checkParams(packedLayout, length):
        length = length or 0
        return length

    @staticmethod
    def __numberOfSetBits(i):
        i = i - (i >> 1 & 1431655765)
        i = (i & 858993459) + (i >> 2 & 858993459)
        return ((i + (i >> 4) & 252645135) * 16843009 & 4294967295) >> 24