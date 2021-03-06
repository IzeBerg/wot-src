

def getMethod(name):

    def _getMethod(self):
        return self.__readonly__[name]

    return _getMethod


class ROPropertyMeta(type):

    def __new__(mcs, className, bases, classDict):
        readonly = classDict.get('__readonly__', {})
        for name, _ in readonly.items():
            classDict[name] = property(getMethod(name))

        return type.__new__(mcs, className, bases, classDict)