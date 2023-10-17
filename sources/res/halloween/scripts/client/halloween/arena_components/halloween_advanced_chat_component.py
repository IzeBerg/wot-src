import BigWorld
from arena_components.advanced_chat_component import AdvancedChatComponent
from chat_commands_consts import BATTLE_CHAT_COMMAND_NAMES
from messenger_common_chat2 import MESSENGER_ACTION_IDS as _ACTIONS

class HWAdvancedChatComponent(AdvancedChatComponent):

    def _getActionMarker(self, cmdID, cmdTargetID):
        entity = BigWorld.entities.get(cmdTargetID)
        if entity and 'hwSoulsCollectorMarker' in entity.dynamicComponents:
            return 'eventCollector'
        else:
            if entity and 'hwCampMarker' in entity.dynamicComponents:
                return 'eventCamp'
            command = _ACTIONS.battleChatCommandFromActionID(cmdID)
            if entity is None and command.name in (BATTLE_CHAT_COMMAND_NAMES.MOVE_TO_TARGET_POINT,
             BATTLE_CHAT_COMMAND_NAMES.MOVING_TO_TARGET_POINT):
                return
            return _ACTIONS.battleChatCommandFromActionID(cmdID).vehMarker