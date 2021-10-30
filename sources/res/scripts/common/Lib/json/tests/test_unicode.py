from collections import OrderedDict
from json.tests import PyTest, CTest

class TestUnicode(object):

    def test_encoding1(self):
        encoder = self.json.JSONEncoder(encoding='utf-8')
        u = 'αΩ'
        s = u.encode('utf-8')
        ju = encoder.encode(u)
        js = encoder.encode(s)
        self.assertEqual(ju, js)

    def test_encoding2(self):
        u = 'αΩ'
        s = u.encode('utf-8')
        ju = self.dumps(u, encoding='utf-8')
        js = self.dumps(s, encoding='utf-8')
        self.assertEqual(ju, js)

    def test_encoding3(self):
        u = 'αΩ'
        j = self.dumps(u)
        self.assertEqual(j, '"\\u03b1\\u03a9"')

    def test_encoding4(self):
        u = 'αΩ'
        j = self.dumps([u])
        self.assertEqual(j, '["\\u03b1\\u03a9"]')

    def test_encoding5(self):
        u = 'αΩ'
        j = self.dumps(u, ensure_ascii=False)
        self.assertEqual(j, ('"{0}"').format(u))

    def test_encoding6(self):
        u = 'αΩ'
        j = self.dumps([u], ensure_ascii=False)
        self.assertEqual(j, ('["{0}"]').format(u))

    def test_big_unicode_encode(self):
        u = '𝄠'
        self.assertEqual(self.dumps(u), '"\\ud834\\udd20"')
        self.assertEqual(self.dumps(u, ensure_ascii=False), '"𝄠"')

    def test_big_unicode_decode(self):
        u = 'z𝄠x'
        self.assertEqual(self.loads('"' + u + '"'), u)
        self.assertEqual(self.loads('"z\\ud834\\udd20x"'), u)

    def test_unicode_decode(self):
        for i in range(0, 55295):
            u = unichr(i)
            s = ('"\\u{0:04x}"').format(i)
            self.assertEqual(self.loads(s), u)

    def test_object_pairs_hook_with_unicode(self):
        s = '{"xkd":1, "kcw":2, "art":3, "hxm":4, "qrt":5, "pad":6, "hoy":7}'
        p = [('xkd', 1), ('kcw', 2), ('art', 3), ('hxm', 4),
         ('qrt', 5), ('pad', 6), ('hoy', 7)]
        self.assertEqual(self.loads(s), eval(s))
        self.assertEqual(self.loads(s, object_pairs_hook=lambda x: x), p)
        od = self.loads(s, object_pairs_hook=OrderedDict)
        self.assertEqual(od, OrderedDict(p))
        self.assertEqual(type(od), OrderedDict)
        self.assertEqual(self.loads(s, object_pairs_hook=OrderedDict, object_hook=lambda x: None), OrderedDict(p))

    def test_default_encoding(self):
        self.assertEqual(self.loads(('{"a": "é"}').encode('utf-8')), {'a': 'é'})

    def test_unicode_preservation(self):
        self.assertEqual(type(self.loads('""')), unicode)
        self.assertEqual(type(self.loads('"a"')), unicode)
        self.assertEqual(type(self.loads('["a"]')[0]), unicode)
        self.assertEqual(type(self.loads('"foo"')), unicode)

    def test_bad_encoding(self):
        self.assertRaises(UnicodeEncodeError, self.loads, '"a"', 'raté')
        self.assertRaises(TypeError, self.loads, '"a"', 1)


class TestPyUnicode(TestUnicode, PyTest):
    pass


class TestCUnicode(TestUnicode, CTest):
    pass