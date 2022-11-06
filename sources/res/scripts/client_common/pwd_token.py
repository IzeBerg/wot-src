import hashlib
from constants import DEFAULT_LANGUAGE
__all__ = ('generate', )

def _generateMd5Hash(pwd):
    md = hashlib.md5()
    md.update(pwd)
    return md.hexdigest()


_BY_LANG = {'cn': _generateMd5Hash, 
   'vn': _generateMd5Hash}

def generate(pwd):
    return pwd


if DEFAULT_LANGUAGE in _BY_LANG:
    generate = _BY_LANG[DEFAULT_LANGUAGE]