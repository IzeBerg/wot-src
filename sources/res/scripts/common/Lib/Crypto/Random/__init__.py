__revision__ = '$Id$'
__all__ = ['new', '_UserFriendlyRNG', 'OSRNG', 'Fortuna']
import OSRNG, Fortuna
from Crypto.Random import _UserFriendlyRNG

def new(*args, **kwargs):
    return _UserFriendlyRNG.new(*args, **kwargs)


def atfork():
    _UserFriendlyRNG.reinit()


def get_random_bytes(n):
    return _UserFriendlyRNG.get_random_bytes(n)