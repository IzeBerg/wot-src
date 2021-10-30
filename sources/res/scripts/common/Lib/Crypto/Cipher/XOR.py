__revision__ = '$Id$'
import _XOR

class XORCipher:

    def __init__(self, key, *args, **kwargs):
        self._cipher = _XOR.new(key, *args, **kwargs)
        self.block_size = self._cipher.block_size
        self.key_size = self._cipher.key_size

    def encrypt(self, plaintext):
        return self._cipher.encrypt(plaintext)

    def decrypt(self, ciphertext):
        return self._cipher.decrypt(ciphertext)


def new(key, *args, **kwargs):
    return XORCipher(key, *args, **kwargs)


block_size = 1
key_size = xrange(1, 33)