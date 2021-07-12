

def getProxy(object_):
    if object_ is not None:
        return object_.proxy
    else:
        return


def getObject(proxy):
    if proxy is not None:
        return proxy.object
    else:
        return


class PyObjectEntity(object):
    __slots__ = ('__cppObject', )

    def __init__(self, cppObject=None):
        super(PyObjectEntity, self).__init__()
        self.__cppObject = None
        if cppObject is not None:
            self.bind(cppObject)
        return

    @property
    def proxy(self):
        return self.__cppObject

    def isBound(self):
        return self.__cppObject is not None

    def unbind(self):
        if self.isBound():
            self._unbind()

    def bind(self, cppObject):
        if self.__cppObject == cppObject:
            return
        else:
            self.unbind()
            self.__cppObject = cppObject
            if cppObject is not None:
                self._bind(cppObject)
            return

    def _bind(self, cppObject):
        cppObject.bindPyObject(self)

    def _unbind(self):
        prevCppObject = self.__cppObject
        self.__cppObject = None
        prevCppObject.unbindPyObject()
        return