import string
try:
    from cPickle import dumps, loads
except ImportError:
    from pickle import dumps, loads

import re, warnings
__all__ = [
 'CookieError', 'BaseCookie', 'SimpleCookie', 'SerialCookie',
 'SmartCookie', 'Cookie']
_nulljoin = ('').join
_semispacejoin = ('; ').join
_spacejoin = (' ').join

class CookieError(Exception):
    pass


_LegalChars = string.ascii_letters + string.digits + "!#$%&'*+-.^_`|~"
_Translator = {'\x00': '\\000', 
   '\x01': '\\001', '\x02': '\\002', '\x03': '\\003', 
   '\x04': '\\004', '\x05': '\\005', '\x06': '\\006', 
   '\x07': '\\007', '\x08': '\\010', '\t': '\\011', 
   '\n': '\\012', '\x0b': '\\013', '\x0c': '\\014', 
   '\r': '\\015', '\x0e': '\\016', '\x0f': '\\017', 
   '\x10': '\\020', '\x11': '\\021', '\x12': '\\022', 
   '\x13': '\\023', '\x14': '\\024', '\x15': '\\025', 
   '\x16': '\\026', '\x17': '\\027', '\x18': '\\030', 
   '\x19': '\\031', '\x1a': '\\032', '\x1b': '\\033', 
   '\x1c': '\\034', '\x1d': '\\035', '\x1e': '\\036', 
   '\x1f': '\\037', ',': '\\054', 
   ';': '\\073', '"': '\\"', 
   '\\': '\\\\', '\x7f': '\\177', 
   b'\x80': '\\200', b'\x81': '\\201', b'\x82': '\\202', 
   b'\x83': '\\203', b'\x84': '\\204', b'\x85': '\\205', 
   b'\x86': '\\206', b'\x87': '\\207', b'\x88': '\\210', 
   b'\x89': '\\211', b'\x8a': '\\212', b'\x8b': '\\213', 
   b'\x8c': '\\214', b'\x8d': '\\215', b'\x8e': '\\216', 
   b'\x8f': '\\217', b'\x90': '\\220', b'\x91': '\\221', 
   b'\x92': '\\222', b'\x93': '\\223', b'\x94': '\\224', 
   b'\x95': '\\225', b'\x96': '\\226', b'\x97': '\\227', 
   b'\x98': '\\230', b'\x99': '\\231', b'\x9a': '\\232', 
   b'\x9b': '\\233', b'\x9c': '\\234', b'\x9d': '\\235', 
   b'\x9e': '\\236', b'\x9f': '\\237', b'\xa0': '\\240', 
   b'\xa1': '\\241', b'\xa2': '\\242', b'\xa3': '\\243', 
   b'\xa4': '\\244', b'\xa5': '\\245', b'\xa6': '\\246', 
   b'\xa7': '\\247', b'\xa8': '\\250', b'\xa9': '\\251', 
   b'\xaa': '\\252', b'\xab': '\\253', b'\xac': '\\254', 
   b'\xad': '\\255', b'\xae': '\\256', b'\xaf': '\\257', 
   b'\xb0': '\\260', b'\xb1': '\\261', b'\xb2': '\\262', 
   b'\xb3': '\\263', b'\xb4': '\\264', b'\xb5': '\\265', 
   b'\xb6': '\\266', b'\xb7': '\\267', b'\xb8': '\\270', 
   b'\xb9': '\\271', b'\xba': '\\272', b'\xbb': '\\273', 
   b'\xbc': '\\274', b'\xbd': '\\275', b'\xbe': '\\276', 
   b'\xbf': '\\277', b'\xc0': '\\300', b'\xc1': '\\301', 
   b'\xc2': '\\302', b'\xc3': '\\303', b'\xc4': '\\304', 
   b'\xc5': '\\305', b'\xc6': '\\306', b'\xc7': '\\307', 
   b'\xc8': '\\310', b'\xc9': '\\311', b'\xca': '\\312', 
   b'\xcb': '\\313', b'\xcc': '\\314', b'\xcd': '\\315', 
   b'\xce': '\\316', b'\xcf': '\\317', b'\xd0': '\\320', 
   b'\xd1': '\\321', b'\xd2': '\\322', b'\xd3': '\\323', 
   b'\xd4': '\\324', b'\xd5': '\\325', b'\xd6': '\\326', 
   b'\xd7': '\\327', b'\xd8': '\\330', b'\xd9': '\\331', 
   b'\xda': '\\332', b'\xdb': '\\333', b'\xdc': '\\334', 
   b'\xdd': '\\335', b'\xde': '\\336', b'\xdf': '\\337', 
   b'\xe0': '\\340', b'\xe1': '\\341', b'\xe2': '\\342', 
   b'\xe3': '\\343', b'\xe4': '\\344', b'\xe5': '\\345', 
   b'\xe6': '\\346', b'\xe7': '\\347', b'\xe8': '\\350', 
   b'\xe9': '\\351', b'\xea': '\\352', b'\xeb': '\\353', 
   b'\xec': '\\354', b'\xed': '\\355', b'\xee': '\\356', 
   b'\xef': '\\357', b'\xf0': '\\360', b'\xf1': '\\361', 
   b'\xf2': '\\362', b'\xf3': '\\363', b'\xf4': '\\364', 
   b'\xf5': '\\365', b'\xf6': '\\366', b'\xf7': '\\367', 
   b'\xf8': '\\370', b'\xf9': '\\371', b'\xfa': '\\372', 
   b'\xfb': '\\373', b'\xfc': '\\374', b'\xfd': '\\375', 
   b'\xfe': '\\376', b'\xff': '\\377'}
_idmap = ('').join(chr(x) for x in xrange(256))

def _quote(str, LegalChars=_LegalChars, idmap=_idmap, translate=string.translate):
    if '' == translate(str, idmap, LegalChars):
        return str
    else:
        return '"' + _nulljoin(map(_Translator.get, str, str)) + '"'


_OctalPatt = re.compile('\\\\[0-3][0-7][0-7]')
_QuotePatt = re.compile('[\\\\].')

def _unquote(str):
    if len(str) < 2:
        return str
    if str[0] != '"' or str[(-1)] != '"':
        return str
    str = str[1:-1]
    i = 0
    n = len(str)
    res = []
    while 0 <= i < n:
        Omatch = _OctalPatt.search(str, i)
        Qmatch = _QuotePatt.search(str, i)
        if not Omatch and not Qmatch:
            res.append(str[i:])
            break
        j = k = -1
        if Omatch:
            j = Omatch.start(0)
        if Qmatch:
            k = Qmatch.start(0)
        if Qmatch and (not Omatch or k < j):
            res.append(str[i:k])
            res.append(str[(k + 1)])
            i = k + 2
        else:
            res.append(str[i:j])
            res.append(chr(int(str[j + 1:j + 4], 8)))
            i = j + 4

    return _nulljoin(res)


_weekdayname = [
 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
_monthname = [
 None,
 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

def _getdate(future=0, weekdayname=_weekdayname, monthname=_monthname):
    from time import gmtime, time
    now = time()
    year, month, day, hh, mm, ss, wd, y, z = gmtime(now + future)
    return '%s, %02d %3s %4d %02d:%02d:%02d GMT' % (
     weekdayname[wd], day, monthname[month], year, hh, mm, ss)


class Morsel(dict):
    _reserved = {'expires': 'expires', 'path': 'Path', 
       'comment': 'Comment', 
       'domain': 'Domain', 
       'max-age': 'Max-Age', 
       'secure': 'secure', 
       'httponly': 'httponly', 
       'version': 'Version'}

    def __init__(self):
        self.key = self.value = self.coded_value = None
        for K in self._reserved:
            dict.__setitem__(self, K, '')

        return

    def __setitem__(self, K, V):
        K = K.lower()
        if K not in self._reserved:
            raise CookieError('Invalid Attribute %s' % K)
        dict.__setitem__(self, K, V)

    def isReservedKey(self, K):
        return K.lower() in self._reserved

    def set(self, key, val, coded_val, LegalChars=_LegalChars, idmap=_idmap, translate=string.translate):
        if key.lower() in self._reserved:
            raise CookieError('Attempt to set a reserved key: %s' % key)
        if '' != translate(key, idmap, LegalChars):
            raise CookieError('Illegal key value: %s' % key)
        self.key = key
        self.value = val
        self.coded_value = coded_val

    def output(self, attrs=None, header='Set-Cookie:'):
        return '%s %s' % (header, self.OutputString(attrs))

    __str__ = output

    def __repr__(self):
        return '<%s: %s=%s>' % (self.__class__.__name__,
         self.key, repr(self.value))

    def js_output(self, attrs=None):
        return '\n        <script type="text/javascript">\n        <!-- begin hiding\n        document.cookie = "%s";\n        // end hiding -->\n        </script>\n        ' % (self.OutputString(attrs).replace('"', '\\"'),)

    def OutputString(self, attrs=None):
        result = []
        RA = result.append
        RA('%s=%s' % (self.key, self.coded_value))
        if attrs is None:
            attrs = self._reserved
        items = self.items()
        items.sort()
        for K, V in items:
            if V == '':
                continue
            if K not in attrs:
                continue
            if K == 'expires' and type(V) == type(1):
                RA('%s=%s' % (self._reserved[K], _getdate(V)))
            elif K == 'max-age' and type(V) == type(1):
                RA('%s=%d' % (self._reserved[K], V))
            elif K == 'secure':
                RA(str(self._reserved[K]))
            elif K == 'httponly':
                RA(str(self._reserved[K]))
            else:
                RA('%s=%s' % (self._reserved[K], V))

        return _semispacejoin(result)


_LegalCharsPatt = "[\\w\\d!#%&'~_`><@,:/\\$\\*\\+\\-\\.\\^\\|\\)\\(\\?\\}\\{\\=]"
_CookiePattern = re.compile('(?x)(?P<key>' + _LegalCharsPatt + '+?)\\s*=\\s*(?P<val>"(?:[^\\\\"]|\\\\.)*"|\\w{3},\\s[\\s\\w\\d-]{9,11}\\s[\\d:]{8}\\sGMT|' + _LegalCharsPatt + '*)\\s*;?')

class BaseCookie(dict):

    def value_decode(self, val):
        return (
         val, val)

    def value_encode(self, val):
        strval = str(val)
        return (strval, strval)

    def __init__(self, input=None):
        if input:
            self.load(input)

    def __set(self, key, real_value, coded_value):
        M = self.get(key, Morsel())
        M.set(key, real_value, coded_value)
        dict.__setitem__(self, key, M)

    def __setitem__(self, key, value):
        rval, cval = self.value_encode(value)
        self.__set(key, rval, cval)

    def output(self, attrs=None, header='Set-Cookie:', sep='\r\n'):
        result = []
        items = self.items()
        items.sort()
        for K, V in items:
            result.append(V.output(attrs, header))

        return sep.join(result)

    __str__ = output

    def __repr__(self):
        L = []
        items = self.items()
        items.sort()
        for K, V in items:
            L.append('%s=%s' % (K, repr(V.value)))

        return '<%s: %s>' % (self.__class__.__name__, _spacejoin(L))

    def js_output(self, attrs=None):
        result = []
        items = self.items()
        items.sort()
        for K, V in items:
            result.append(V.js_output(attrs))

        return _nulljoin(result)

    def load(self, rawdata):
        if type(rawdata) == type(''):
            self.__ParseString(rawdata)
        else:
            for k, v in rawdata.items():
                self[k] = v

    def __ParseString(self, str, patt=_CookiePattern):
        i = 0
        n = len(str)
        M = None
        while 0 <= i < n:
            match = patt.search(str, i)
            if not match:
                break
            K, V = match.group('key'), match.group('val')
            i = match.end(0)
            if K[0] == '$':
                if M:
                    M[K[1:]] = V
            elif K.lower() in Morsel._reserved:
                if M:
                    M[K] = _unquote(V)
            else:
                rval, cval = self.value_decode(V)
                self.__set(K, rval, cval)
                M = self[K]

        return


class SimpleCookie(BaseCookie):

    def value_decode(self, val):
        return (
         _unquote(val), val)

    def value_encode(self, val):
        strval = str(val)
        return (strval, _quote(strval))


class SerialCookie(BaseCookie):

    def __init__(self, input=None):
        warnings.warn('SerialCookie class is insecure; do not use it', DeprecationWarning)
        BaseCookie.__init__(self, input)

    def value_decode(self, val):
        return (
         loads(_unquote(val)), val)

    def value_encode(self, val):
        return (val, _quote(dumps(val)))


class SmartCookie(BaseCookie):

    def __init__(self, input=None):
        warnings.warn('Cookie/SmartCookie class is insecure; do not use it', DeprecationWarning)
        BaseCookie.__init__(self, input)

    def value_decode(self, val):
        strval = _unquote(val)
        try:
            return (
             loads(strval), val)
        except:
            return (
             strval, val)

    def value_encode(self, val):
        if type(val) == type(''):
            return (val, _quote(val))
        else:
            return (
             val, _quote(dumps(val)))


Cookie = SmartCookie

def _test():
    import doctest, Cookie
    return doctest.testmod(Cookie)


if __name__ == '__main__':
    _test()