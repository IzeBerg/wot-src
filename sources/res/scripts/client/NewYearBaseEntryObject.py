from ClientSelectableObject import ClientSelectableObject
from entity_constants import HighlightColors
from helpers import dependency
from skeletons.gui.shared.utils import IHangarSpace
from skeletons.new_year import INewYearController

class NewYearBaseEntryObject(ClientSelectableObject):
    _hangarSpace = dependency.descriptor(IHangarSpace)
    _nyController = dependency.descriptor(INewYearController)
    _HIGHLIGHT_COLOR = HighlightColors.BLUE

    def onEnterWorld(self, prereqs):
        super(NewYearBaseEntryObject, self).onEnterWorld(prereqs)
        self._nyController.onStateChanged += self.__onStateChanged
        self.__onStateChanged()

    def onLeaveWorld(self):
        self._nyController.onStateChanged -= self.__onStateChanged
        super(NewYearBaseEntryObject, self).onLeaveWorld()

    def __onStateChanged(self):
        self.setEnable(self._nyController.isEnabled())