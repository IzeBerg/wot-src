from abc import ABCMeta, abstractmethod

class Config(object):
    __metaclass__ = ABCMeta

    def __init__(self, **kwargs):
        map(lambda item: setattr(self, *item), kwargs.iteritems())

    @classmethod
    @abstractmethod
    def create(cls, *args, **kwargs):
        pass