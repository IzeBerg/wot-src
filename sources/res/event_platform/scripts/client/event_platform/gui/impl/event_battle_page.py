from debug_utils import LOG_ERROR
from gui.Scaleform.daapi.view.battle.classic import ClassicPage
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES

class EventBattlePage(ClassicPage):

    def __init__(self, components=None, external=None, fullStatsAlias=BATTLE_VIEW_ALIASES.FULL_STATS):
        LOG_ERROR('INIT --- EventBattlePage')
        super(EventBattlePage, self).__init__(components=components, external=external, fullStatsAlias=fullStatsAlias)