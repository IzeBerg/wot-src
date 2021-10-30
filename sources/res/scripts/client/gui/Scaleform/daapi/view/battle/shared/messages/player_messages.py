import logging
from constants import EQUIPMENT_STAGES
from gui.battle_control.battle_constants import FEEDBACK_EVENT_ID
from gui.battle_royale.constants import BR_EQUIPMENTS_WITH_MESSAGES
from gui.Scaleform.daapi.view.battle.shared.messages import fading_messages
from items import vehicles
_logger = logging.getLogger(__name__)
_ID_TO_DESTRUCTIBLE_ENTITY_NAME = {1: '1', 
   2: '2', 
   3: '3', 
   4: '4', 
   5: '5'}
_EQUIPMENT_NAME_TO_POSTFIX_KEY = {'arcade_bomber_battle_royale': 'BOMBER', 
   'arcade_smoke_battle_royale': 'SMOKE', 
   'fl_regenerationKit': 'REGENERATION_KIT_EPIC', 
   'arcade_minefield_epic_battle': 'MINEFIELD_EPIC', 
   'stealth_radar': 'STEALTH_RADAR'}
_EVENT_ACTION_TO_KEY = {'healVehicleAction': 'EVENT_HEAL', 
   'addAmmoVehicleAction': 'EVENT_ADD_AMMO'}

class PlayerMessages(fading_messages.FadingMessages):

    def __init__(self):
        super(PlayerMessages, self).__init__('PlayerMessagesPanel', 'player_messages_panel.xml')

    def __del__(self):
        _logger.debug('PlayerMessages panel is deleted')

    def _addGameListeners(self):
        super(PlayerMessages, self)._addGameListeners()
        ctrl = self.sessionProvider.shared.messages
        if ctrl is not None:
            ctrl.onShowPlayerMessageByCode += self.__onShowPlayerMessageByCode
            ctrl.onShowPlayerMessageByKey += self.__onShowPlayerMessageByKey
            ctrl.onShowDestructibleEntityMessageByCode += self.__onShowDestructibleEntityMessageByCode
        ctrl = self.sessionProvider.shared.equipments
        if ctrl is not None:
            ctrl.onEquipmentUpdated += self.__onCombatEquipmentUpdated
            ctrl.onCombatEquipmentUsed += self.__onCombatEquipmentUsed
        ctrl = self.sessionProvider.shared.feedback
        if ctrl is not None:
            ctrl.onPlayerFeedbackReceived += self._onPlayerFeedbackReceived
        return

    def _removeGameListeners(self):
        ctrl = self.sessionProvider.shared.messages
        if ctrl is not None:
            ctrl.onShowPlayerMessageByCode -= self.__onShowPlayerMessageByCode
            ctrl.onShowPlayerMessageByKey -= self.__onShowPlayerMessageByKey
            ctrl.onShowDestructibleEntityMessageByCode -= self.__onShowDestructibleEntityMessageByCode
        ctrl = self.sessionProvider.shared.equipments
        if ctrl is not None:
            ctrl.onEquipmentUpdated -= self.__onCombatEquipmentUpdated
            ctrl.onCombatEquipmentUsed -= self.__onCombatEquipmentUsed
        ctrl = self.sessionProvider.shared.feedback
        if ctrl is not None:
            ctrl.onPlayerFeedbackReceived -= self._onPlayerFeedbackReceived
        super(PlayerMessages, self)._removeGameListeners()
        return

    def _onPlayerFeedbackReceived(self, events):
        for event in events:
            eventType = event.getType()
            if eventType == FEEDBACK_EVENT_ID.EVENT_ACTION_APPLIED:
                _, actionValue, actionName = event.getExtra()
                if actionName in _EVENT_ACTION_TO_KEY:
                    self.showMessage(_EVENT_ACTION_TO_KEY[actionName], {'value': str(actionValue)})

    def __onShowDestructibleEntityMessageByCode(self, code, entityID, attackerID):
        _logger.debug('onShowDestructibleEntityMessage %r %r %r', code, entityID, attackerID)
        getFullName = self.sessionProvider.getCtx().getPlayerFullName
        self.showMessage(code, {'target': _ID_TO_DESTRUCTIBLE_ENTITY_NAME[entityID], 
           'attacker': getFullName(attackerID, showClan=False)})

    def __onShowPlayerMessageByCode(self, code, postfix, targetID, attackerID, equipmentID):
        _logger.debug('onShowPlayerMessage %r %r %r %r %r', code, postfix, targetID, attackerID, equipmentID)
        getFullName = self.sessionProvider.getCtx().getPlayerFullName
        if equipmentID:
            equipment = vehicles.g_cache.equipments().get(equipmentID)
            if equipment is not None:
                postfix = ('_').join((postfix, equipment.name.split('_')[0].upper()))
        self.showMessage(code, {'target': getFullName(targetID, showClan=False), 
           'attacker': getFullName(attackerID, showClan=False)}, extra=(
         (
          'target', targetID), ('attacker', attackerID)), postfix=postfix)
        return

    def __onShowPlayerMessageByKey(self, key, args=None, extra=None):
        self.showMessage(key, args, extra)

    def __onCombatEquipmentUpdated(self, _, item):
        if not item.becomeReady:
            return
        itemDescriptor = item.getDescriptor()
        if itemDescriptor.name in BR_EQUIPMENTS_WITH_MESSAGES:
            if item.getPrevStage() == EQUIPMENT_STAGES.COOLDOWN and item.getQuantity() == 0:
                return
            self.showMessage('COMBAT_BR_EQUIPMENT_READY', {'equipment': itemDescriptor.userString})
        else:
            self.showMessage('COMBAT_EQUIPMENT_READY', {}, postfix=self.__getPostfixFromEquipmentName(itemDescriptor.name))

    def __onCombatEquipmentUsed(self, shooterID, eqID):
        battleCxt = self.sessionProvider.getCtx()
        if not battleCxt.isCurrentPlayer(shooterID):
            equipment = vehicles.g_cache.equipments().get(eqID)
            getFullName = battleCxt.getPlayerFullName
            if equipment is None:
                return
            self.showMessage('COMBAT_EQUIPMENT_USED', {'player': getFullName(shooterID, showClan=False)}, extra=(
             (
              'player', shooterID),), postfix=self.__getPostfixFromEquipmentName(equipment.name))
        return

    @staticmethod
    def __getPostfixFromEquipmentName(name):
        if 'level' in name:
            postfix = _EQUIPMENT_NAME_TO_POSTFIX_KEY.get(name.partition('level')[0].rstrip('_'))
        else:
            postfix = _EQUIPMENT_NAME_TO_POSTFIX_KEY.get(name)
        if postfix is None:
            postfix = name.split('_')[0].upper()
        return postfix