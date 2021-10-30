__revision__ = '$Id$'
import types, warnings
from Crypto.Util.number import *

class pubkey:

    def __init__(self):
        pass

    def __getstate__(self):
        d = self.__dict__
        for key in self.keydata:
            if d.has_key(key):
                d[key] = long(d[key])

        return d

    def __setstate__(self, d):
        for key in self.keydata:
            if d.has_key(key):
                self.__dict__[key] = bignum(d[key])

    def encrypt(self, plaintext, K):
        wasString = 0
        if isinstance(plaintext, types.StringType):
            plaintext = bytes_to_long(plaintext)
            wasString = 1
        if isinstance(K, types.StringType):
            K = bytes_to_long(K)
        ciphertext = self._encrypt(plaintext, K)
        if wasString:
            return tuple(map(long_to_bytes, ciphertext))
        else:
            return ciphertext

    def decrypt(self, ciphertext):
        wasString = 0
        if not isinstance(ciphertext, types.TupleType):
            ciphertext = (
             ciphertext,)
        if isinstance(ciphertext[0], types.StringType):
            ciphertext = tuple(map(bytes_to_long, ciphertext))
            wasString = 1
        plaintext = self._decrypt(ciphertext)
        if wasString:
            return long_to_bytes(plaintext)
        else:
            return plaintext

    def sign(self, M, K):
        if not self.has_private():
            raise TypeError('Private key not available in this object')
        if isinstance(M, types.StringType):
            M = bytes_to_long(M)
        if isinstance(K, types.StringType):
            K = bytes_to_long(K)
        return self._sign(M, K)

    def verify(self, M, signature):
        if isinstance(M, types.StringType):
            M = bytes_to_long(M)
        return self._verify(M, signature)

    def validate(self, M, signature):
        warnings.warn('validate() method name is obsolete; use verify()', DeprecationWarning)

    def blind(self, M, B):
        wasString = 0
        if isinstance(M, types.StringType):
            M = bytes_to_long(M)
            wasString = 1
        if isinstance(B, types.StringType):
            B = bytes_to_long(B)
        blindedmessage = self._blind(M, B)
        if wasString:
            return long_to_bytes(blindedmessage)
        else:
            return blindedmessage

    def unblind(self, M, B):
        wasString = 0
        if isinstance(M, types.StringType):
            M = bytes_to_long(M)
            wasString = 1
        if isinstance(B, types.StringType):
            B = bytes_to_long(B)
        unblindedmessage = self._unblind(M, B)
        if wasString:
            return long_to_bytes(unblindedmessage)
        else:
            return unblindedmessage

    def can_sign(self):
        return 1

    def can_encrypt(self):
        return 1

    def can_blind(self):
        return 0

    def size(self):
        return 0

    def has_private(self):
        return 0

    def publickey(self):
        return self

    def __eq__(self, other):
        return self.__getstate__() == other.__getstate__()

    def __ne__(self, other):
        return not self.__eq__(other)