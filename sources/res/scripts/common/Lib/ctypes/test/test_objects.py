import unittest, doctest, sys, ctypes.test.test_objects

class TestCase(unittest.TestCase):
    if sys.hexversion > 33816576:

        def test(self):
            doctest.testmod(ctypes.test.test_objects)


if __name__ == '__main__':
    if sys.hexversion > 33816576:
        doctest.testmod(ctypes.test.test_objects)