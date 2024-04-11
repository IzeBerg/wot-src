import logging
from gui.doc_loaders import messages_panel_reader
from gui.Scaleform.daapi.view.battle.shared.messages import player_messages
_logger = logging.getLogger(__name__)
_HB_PLAYER_MESSAGES_PATH = 'historical_battles/gui/player_messages_panel.xml'
_HB_EQUIPMENT_NAME_TO_POSTFIX_KEY = {'arcade_teamRepairKit_historical_battles': 'REGENERATION_KIT_EPIC', 
   'arcade_artillery_historical_battles': 'ARCADE_ARTILLERY_HISTORICAL_BATTLES', 
   'super_shot_1': 'SUPER_SHOT'}

class HistoricalBattlePlayerMessages(player_messages.PlayerMessages):

    def showMessage(self, key, args=None, extra=None, postfix=''):
        if key == 'DEATH_FROM_DEATH_ZONE':
            key = 'EVENT_DEATH_FROM_DEATH_ZONE'
        elif postfix in ('SELF_ENEMY', 'ALLY_ENEMY'):
            key = 'EVENT_DEATH'
        super(HistoricalBattlePlayerMessages, self).showMessage(key, args=args, extra=extra, postfix=postfix)

    def _populate(self):
        super(HistoricalBattlePlayerMessages, self)._populate()
        _, _, messages = messages_panel_reader.readXML(_HB_PLAYER_MESSAGES_PATH)
        self._messages.update(messages)

    def _onShowPlayerMessageByCode(self, code, postfix, targetID, attackerID, equipmentID, ignoreMessages):
        _logger.debug('onShowPlayerMessage %r %r %r %r %r', code, postfix, targetID, attackerID, equipmentID)
        if ignoreMessages:
            return
        self.showMessage(code, {'target': self._getFullName(targetID), 
           'attacker': self._getFullName(attackerID)}, extra=(
         (
          'target', targetID), ('attacker', attackerID)), postfix=postfix)

    def _getFullName(self, vehicleID):
        isBot = self.sessionProvider.getArenaDP().getVehicleInfo(vehicleID).isBot
        getFullName = self.sessionProvider.getCtx().getPlayerFullName
        if isBot:
            return getFullName(vehicleID, showClan=False, showName=False)
        return getFullName(vehicleID, showClan=False)