from gui.Scaleform.daapi.view.meta.MapInfoTipMeta import MapInfoTipMeta
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider

class MapInfoTip(MapInfoTipMeta):
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def _populate(self):
        super(MapInfoTip, self)._populate()
        self.as_setEnabledS(self.__sessionProvider.arenaVisitor.extra.isMapsInDevelopmentEnabled())