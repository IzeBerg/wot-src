from typing import TYPE_CHECKING
from account_helpers import AccountSettings
if TYPE_CHECKING:
    from typing import Any
_COSMIC_KEY = 'cosmic_keys'
_EVENT_STARTED_NOTIFICATION_VIEWED = 'event_started_notification_viewed'
_RESEARCH_DONE = 'cosmic_artifact_research_done'
_BATTLE_HINT_COUNTERS = 'battle_hint_counters'
PRB_HINT_NUM = 'prb_hint_num'
_LOBBY_OPENED = 'lobby_opened'
_DAILY_Q_COMPLETED_DAY = 'daily_completed_day'
ACCOUNT_DEFAULT_SETTINGS = {_COSMIC_KEY: {_EVENT_STARTED_NOTIFICATION_VIEWED: False, 
                 PRB_HINT_NUM: 0, 
                 _RESEARCH_DONE: False, 
                 _BATTLE_HINT_COUNTERS: {}, _LOBBY_OPENED: False, 
                 _DAILY_Q_COMPLETED_DAY: 0}}

def getSettings(name):
    settings = AccountSettings.getSettings(_COSMIC_KEY)
    return settings.get(name, ACCOUNT_DEFAULT_SETTINGS[_COSMIC_KEY].get(name))


def setSettings(name, value):
    settings = AccountSettings.getSettings(_COSMIC_KEY)
    settings[name] = value
    AccountSettings.setSettings(_COSMIC_KEY, settings)


def resetSettings():
    for key, value in ACCOUNT_DEFAULT_SETTINGS[_COSMIC_KEY].items():
        setSettings(key, value)


def isEventStartedNotificationViewed():
    return getSettings(_EVENT_STARTED_NOTIFICATION_VIEWED)


def setEventStartedNotificationViewed(status):
    return setSettings(_EVENT_STARTED_NOTIFICATION_VIEWED, status)


def isResearchDoneViewDisplayed():
    return getSettings(_RESEARCH_DONE)


def setResearchDoneViewDisplayed():
    setSettings(_RESEARCH_DONE, True)


def getBattleHintCounter(hintName):
    return getSettings(_BATTLE_HINT_COUNTERS).get(hintName, 0)


def incrementBattleHintCounter(hintName):
    counters = getSettings(_BATTLE_HINT_COUNTERS)
    counters[hintName] = counters.get(hintName, 0) + 1
    setSettings(_BATTLE_HINT_COUNTERS, counters)


def getLobbyOpened():
    return getSettings(_LOBBY_OPENED)


def setLobbyOpened(status):
    setSettings(_LOBBY_OPENED, status)


def getLastDailyQDay():
    return getSettings(_DAILY_Q_COMPLETED_DAY)


def setLastDailyQDay(status):
    setSettings(_DAILY_Q_COMPLETED_DAY, status)