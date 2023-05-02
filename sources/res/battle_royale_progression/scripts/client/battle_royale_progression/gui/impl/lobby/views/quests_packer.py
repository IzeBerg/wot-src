import constants
from gui.server_events.events_helpers import isPremium, isDailyQuest
from gui.shared.missions.packers.events import TokenUIDataPacker, PrivateMissionUIDataPacker, DailyQuestUIDataPacker

def getEventUIDataPacker(event):
    if event.getType() == constants.EVENT_TYPE.TOKEN_QUEST:
        return TokenUIDataPacker(event)
    else:
        if event.getType() == constants.EVENT_TYPE.PERSONAL_QUEST:
            return PrivateMissionUIDataPacker(event)
        if isPremium(event.getID()) or isDailyQuest(event.getID()) or event.getType() in constants.EVENT_TYPE.LIKE_BATTLE_QUESTS:
            return DailyQuestUIDataPacker(event)
        return