import logging
from gui.Scaleform.daapi.view.lobby.header.BattleTypeSelectPopover import BattleTypeSelectPopover
_logger = logging.getLogger(__name__)

class BCBattleSelector(BattleTypeSelectPopover):

    def as_updateS(self, items, extraItems, isShowDemonstrator, demonstratorEnabled):
        _logger.debug('BCBattleSelector, %s', items)
        for battleTypeItem in items:
            if battleTypeItem['data'] != 'random':
                battleTypeItem['disabled'] = True

        super(BCBattleSelector, self).as_updateS(items, extraItems, isShowDemonstrator, demonstratorEnabled)