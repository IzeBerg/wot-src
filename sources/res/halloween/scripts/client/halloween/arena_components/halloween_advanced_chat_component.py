import BigWorld
from arena_components.advanced_chat_component import AdvancedChatComponent
from chat_commands_consts import BATTLE_CHAT_COMMAND_NAMES
from halloween_common.halloween_constants import HalloweenMarkerComponentNames
from messenger_common_chat2 import MESSENGER_ACTION_IDS as _ACTIONS

class HWAdvancedChatComponent(AdvancedChatComponent):

    def _getActionMarker(self, cmdID, cmdTargetID):
        command = _ACTIONS.battleChatCommandFromActionID(cmdID)
        if command.name in (BATTLE_CHAT_COMMAND_NAMES.MOVE_TO_TARGET_POINT,
         BATTLE_CHAT_COMMAND_NAMES.MOVING_TO_TARGET_POINT):
            entity = BigWorld.entities.get(cmdTargetID)
            if entity and HalloweenMarkerComponentNames.SOULS_COLLECTOR in entity.dynamicComponents:
                return 'eventCollector'
            if entity and HalloweenMarkerComponentNames.CAMP in entity.dynamicComponents:
                return 'eventCamp'
            return None
        return _ACTIONS.battleChatCommandFromActionID(cmdID).vehMarker