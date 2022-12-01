

class HistoryManager(object):
    __instance = None

    @staticmethod
    def getInstance():
        if HistoryManager.__instance is None:
            HistoryManager.__instance = HistoryManager()
        return HistoryManager.__instance

    def __init__(self):
        self.__commands = []
        self.__prevContext = None
        self.__backButtonText = None
        return

    def getBackButtonText(self):
        return self.__backButtonText

    def addToHistory(self, command):
        self.__commands.append(command)
        self.__updatePrev()

    def goBack(self):
        command = self.__commands.pop()
        command.execute()
        self.__updatePrev()

    def getPrevContext(self):
        return self.__prevContext

    def pop(self):
        self.__commands.pop()
        self.__updatePrev()

    def clear(self):
        self.__prevContext = None
        self.__backButtonText = None
        self.__commands = []
        return

    def __updatePrev(self):
        prevCommand = self.__getLast()
        if prevCommand:
            self.__prevContext = prevCommand.getContext()
            self.__backButtonText = prevCommand.getBackButtonText()
        else:
            self.__prevContext = None
            self.__backButtonText = None
        return

    def __getLast(self):
        if self.__commands:
            return self.__commands[(-1)]
        else:
            return

    def hasPrevViews(self):
        return len(self.__commands) > 0