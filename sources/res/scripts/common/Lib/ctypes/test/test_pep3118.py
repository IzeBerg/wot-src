import unittest
from ctypes import *
import re, sys
if sys.byteorder == 'little':
    THIS_ENDIAN = '<'
    OTHER_ENDIAN = '>'
else:
    THIS_ENDIAN = '>'
    OTHER_ENDIAN = '<'

def normalize(format):
    if format is None:
        return ''
    else:
        format = format.replace(OTHER_ENDIAN, THIS_ENDIAN)
        return re.sub('\\s', '', format)


class Test(unittest.TestCase):

    def test_native_types(self):
        for tp, fmt, shape, itemtp in native_types:
            ob = tp()
            v = memoryview(ob)
            try:
                self.assertEqual(normalize(v.format), normalize(fmt))
                if shape is not None:
                    self.assertEqual(len(v), shape[0])
                else:
                    self.assertEqual(len(v) * sizeof(itemtp), sizeof(ob))
                self.assertEqual(v.itemsize, sizeof(itemtp))
                self.assertEqual(v.shape, shape)
                self.assertEqual(v.strides, None)
                self.assertFalse(v.readonly)
                if v.shape:
                    n = 1
                    for dim in v.shape:
                        n = n * dim

                    self.assertEqual(n * v.itemsize, len(v.tobytes()))
            except:
                print tp
                raise

        return

    def test_endian_types(self):
        for tp, fmt, shape, itemtp in endian_types:
            ob = tp()
            v = memoryview(ob)
            try:
                self.assertEqual(v.format, fmt)
                if shape is not None:
                    self.assertEqual(len(v), shape[0])
                else:
                    self.assertEqual(len(v) * sizeof(itemtp), sizeof(ob))
                self.assertEqual(v.itemsize, sizeof(itemtp))
                self.assertEqual(v.shape, shape)
                self.assertEqual(v.strides, None)
                self.assertFalse(v.readonly)
                if v.shape:
                    n = 1
                    for dim in v.shape:
                        n = n * dim

                    self.assertEqual(n, len(v))
            except:
                print tp
                raise

        return


class Point(Structure):
    _fields_ = [
     (
      'x', c_long), ('y', c_long)]


class PackedPoint(Structure):
    _pack_ = 2
    _fields_ = [('x', c_long), ('y', c_long)]


class Point2(Structure):
    pass


Point2._fields_ = [
 (
  'x', c_long), ('y', c_long)]

class EmptyStruct(Structure):
    _fields_ = []


class aUnion(Union):
    _fields_ = [
     (
      'a', c_int)]


class StructWithArrays(Structure):
    _fields_ = [
     (
      'x', c_long * 3 * 2), ('y', Point * 4)]


class Incomplete(Structure):
    pass


class Complete(Structure):
    pass


PComplete = POINTER(Complete)
Complete._fields_ = [('a', c_long)]
native_types = [
 (
  c_char, '<c', None, c_char),
 (
  c_byte, '<b', None, c_byte),
 (
  c_ubyte, '<B', None, c_ubyte),
 (
  c_short, '<h', None, c_short),
 (
  c_ushort, '<H', None, c_ushort),
 (
  c_long, '<l', None, c_long),
 (
  c_ulong, '<L', None, c_ulong),
 (
  c_float, '<f', None, c_float),
 (
  c_double, '<d', None, c_double),
 (
  c_bool, '<?', None, c_bool),
 (
  py_object, '<O', None, py_object),
 (
  POINTER(c_byte), '&<b', None, POINTER(c_byte)),
 (
  POINTER(POINTER(c_long)), '&&<l', None, POINTER(POINTER(c_long))),
 (
  c_double * 4, '<d', (4, ), c_double),
 (
  c_float * 4 * 3 * 2, '<f', (2, 3, 4), c_float),
 (
  POINTER(c_short) * 2, '&<h', (2, ), POINTER(c_short)),
 (
  POINTER(c_short) * 2 * 3, '&<h', (3, 2), POINTER(c_short)),
 (
  POINTER(c_short * 2), '&(2)<h', None, POINTER(c_short)),
 (
  Point, 'T{<l:x:<l:y:}', None, Point),
 (
  PackedPoint, 'B', None, PackedPoint),
 (
  Point2, 'T{<l:x:<l:y:}', None, Point2),
 (
  EmptyStruct, 'T{}', None, EmptyStruct),
 (
  aUnion, 'B', None, aUnion),
 (
  StructWithArrays, 'T{(2,3)<l:x:(4)T{<l:x:<l:y:}:y:}', None, StructWithArrays),
 (
  StructWithArrays * 3, 'T{(2,3)<l:x:(4)T{<l:x:<l:y:}:y:}', (3, ), StructWithArrays),
 (
  Incomplete, 'B', None, Incomplete),
 (
  POINTER(Incomplete), '&B', None, POINTER(Incomplete)),
 (
  Complete, 'T{<l:a:}', None, Complete),
 (
  POINTER(Complete), '&B', None, POINTER(Complete)),
 (
  CFUNCTYPE(None), 'X{}', None, CFUNCTYPE(None))]

class BEPoint(BigEndianStructure):
    _fields_ = [
     (
      'x', c_long), ('y', c_long)]


class LEPoint(LittleEndianStructure):
    _fields_ = [
     (
      'x', c_long), ('y', c_long)]


endian_types = [
 (
  BEPoint, 'T{>l:x:>l:y:}', None, BEPoint),
 (
  LEPoint, 'T{<l:x:<l:y:}', None, LEPoint),
 (
  POINTER(BEPoint), '&T{>l:x:>l:y:}', None, POINTER(BEPoint)),
 (
  POINTER(LEPoint), '&T{<l:x:<l:y:}', None, POINTER(LEPoint))]
if __name__ == '__main__':
    unittest.main()