from soft_exception import SoftException
__all__ = ('SerializationException', 'FoundItemException')

class SerializationException(SoftException):
    pass


class FoundItemException(SoftException):
    pass