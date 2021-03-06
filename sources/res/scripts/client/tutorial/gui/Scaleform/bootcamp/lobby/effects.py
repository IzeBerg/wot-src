from tutorial.gui.Scaleform.effects_player import ApplicationEffect, GUIEffectScope
from tutorial.logger import LOG_ERROR

class ShowHint(ApplicationEffect):
    __slots__ = ('_itemID', )

    def __init__(self):
        super(ShowHint, self).__init__()
        self._itemID = None
        return

    def play(self, effectData):
        requestedItemID = effectData
        if self._itemID is not None and self._itemID != requestedItemID:
            LOG_ERROR('Another hint is already active. Bootcamp hints are exclusive.', self._itemID, requestedItemID)
            return False
        else:
            layout = self._getTutorialLayout()
            if layout is None:
                return False
            if layout.showBootcampHint(requestedItemID):
                self._itemID = requestedItemID
                return True
            return False

    def stop(self, effectID=None, effectSubType=None):
        if self._itemID is not None and effectID in (self._itemID, None):
            layout = self._getTutorialLayout()
            if layout is not None:
                layout.hideBootcampHint(self._itemID)
            self._itemID = None
        return

    def cancel(self, scopeType, scopeName):
        if scopeType == GUIEffectScope.COMPONENT:
            self.stop(scopeName)