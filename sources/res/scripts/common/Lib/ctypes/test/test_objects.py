import unittest, doctest, sys, ctypes.test.test_objects

class TestCase(unittest.TestCase):

    def test(self):
        failures, tests = doctest.testmod(ctypes.test.test_objects)
        self.assertFalse(failures, 'doctests failed, see output above')


if __name__ == '__main__':
    doctest.testmod(ctypes.test.test_objects)