from gui.impl.new_year.navigation import NewYearNavigation
from uilogging.ny.loggers import NySelectableObjectLogger, NySelectableObjectFlowLogger

class SelectableObjectLoggerMixin(object):
    __selectableObjectLogger = NySelectableObjectLogger()
    __flowUILogger = NySelectableObjectFlowLogger()

    def logClick(self, anchorName):
        currentObject = NewYearNavigation.getCurrentObject()
        self.__selectableObjectLogger.logClick(anchorName, currentObject)
        self.__flowUILogger.logClick(anchorName, currentObject)