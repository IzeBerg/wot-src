from festivity.dummy.df_controller import DummyController
from festivity.dummy.df_processor import DummyCommandsProcessor
from festivity.dummy.df_requester import DummyRequester
from skeletons.festivity_factory import IFestivityFactory

class DummyFactory(IFestivityFactory):

    def __init__(self):
        super(DummyFactory, self).__init__()
        self.__requester = DummyRequester()
        self.__processor = DummyCommandsProcessor()
        self.__controller = DummyController()

    def getRequester(self):
        return self.__requester

    def getProcessor(self):
        return self.__processor

    def getController(self):
        return self.__controller

    def getDataSyncKey(self):
        return 'dummySyncKey'