import logging
from collections import namedtuple
from gui.impl import backport
from gui.impl.gen import R
from shared_utils import ScalarTypes
log = logging.getLogger(__name__)
LIST_SCROLL_STEP_FACTOR = 10
DEF_ICON_NAME = '{0:>s}_1'
DEF_ICON_PATH = '../maps/icons/library/{0:>s}-1.png'
NotificationData = namedtuple('NotificationData', ('entityID', 'savedData', 'priorityLevel',
                                                   'entity'))

class NOTIFICATION_STATE(object):
    POPUPS = 0
    LIST = 1


class NOTIFICATION_TYPE(object):
    UNDEFINED = 0
    MESSAGE = 1
    INVITE = 2
    FRIENDSHIP_RQ = 3
    WGNC_POP_UP = 4
    CLAN_INVITES = 5
    CLAN_APPS = 6
    CLAN_APP_ACTION = 7
    CLAN_INVITE_ACTION = 8
    CLAN_INVITE = 9
    CLAN_APP = 10
    PROGRESSIVE_REWARD = 11
    MISSING_EVENTS = 12
    RECRUIT_REMINDER = 13
    EMAIL_CONFIRMATION_REMINDER = 14
    BATTLE_PASS_SWITCH_CHAPTER_REMINDER = 15
    SENIORITY_AWARDS_TOKENS = 16
    SENIORITY_AWARDS_QUEST = 17
    RESOURCE_WELL_START = 18
    AUCTION_STAGE_START = 19
    AUCTION_STAGE_FINISH = 20
    WINBACK_SELECTABLE_REWARD_AVAILABLE = 21
    WOT_PLUS_INTRO = 22
    BATTLE_MATTERS_TASK_REMINDER = 23
    PRESTIGE_FIRST_ENTRY = 24
    COLLECTIONS_ENTRY = 25
    COLLECTIONS_RENEW = 26
    SENIORITY_AWARDS_VEHICLE_SELECTION = 27
    RANGE = None


NOTIFICATION_TYPE.RANGE = frozenset(v for k, v in NOTIFICATION_TYPE.__dict__.items() if not k.startswith('_') and isinstance(v, ScalarTypes) and v != NOTIFICATION_TYPE.UNDEFINED)
ITEMS_MAX_LENGTHS = {NOTIFICATION_TYPE.MESSAGE: 250, 
   NOTIFICATION_TYPE.INVITE: 100, 
   NOTIFICATION_TYPE.FRIENDSHIP_RQ: 100, 
   NOTIFICATION_TYPE.WGNC_POP_UP: 500, 
   NOTIFICATION_TYPE.CLAN_APPS: 1, 
   NOTIFICATION_TYPE.CLAN_INVITES: 1, 
   NOTIFICATION_TYPE.CLAN_APP_ACTION: 500, 
   NOTIFICATION_TYPE.CLAN_INVITE_ACTION: 500, 
   NOTIFICATION_TYPE.CLAN_INVITE: 500, 
   NOTIFICATION_TYPE.CLAN_APP: 500, 
   NOTIFICATION_TYPE.PROGRESSIVE_REWARD: 1, 
   NOTIFICATION_TYPE.MISSING_EVENTS: 1, 
   NOTIFICATION_TYPE.RECRUIT_REMINDER: 1, 
   NOTIFICATION_TYPE.EMAIL_CONFIRMATION_REMINDER: 1, 
   NOTIFICATION_TYPE.BATTLE_PASS_SWITCH_CHAPTER_REMINDER: 1, 
   NOTIFICATION_TYPE.RESOURCE_WELL_START: 1, 
   NOTIFICATION_TYPE.AUCTION_STAGE_START: 1, 
   NOTIFICATION_TYPE.AUCTION_STAGE_FINISH: 1, 
   NOTIFICATION_TYPE.SENIORITY_AWARDS_TOKENS: 1, 
   NOTIFICATION_TYPE.SENIORITY_AWARDS_QUEST: 1, 
   NOTIFICATION_TYPE.WINBACK_SELECTABLE_REWARD_AVAILABLE: 1, 
   NOTIFICATION_TYPE.WOT_PLUS_INTRO: 1, 
   NOTIFICATION_TYPE.BATTLE_MATTERS_TASK_REMINDER: 1, 
   NOTIFICATION_TYPE.PRESTIGE_FIRST_ENTRY: 1, 
   NOTIFICATION_TYPE.COLLECTIONS_ENTRY: 1, 
   NOTIFICATION_TYPE.COLLECTIONS_RENEW: 50, 
   NOTIFICATION_TYPE.SENIORITY_AWARDS_VEHICLE_SELECTION: 1}

class NOTIFICATION_BUTTON_STATE(object):
    HIDDEN = 0
    VISIBLE = 1
    ENABLED = 2
    DEFAULT = VISIBLE | ENABLED


def makePathToIcon(iconName):
    if not iconName:
        return ''
    iconRes = R.images.gui.maps.icons.library.dyn(DEF_ICON_NAME.format(iconName))
    if not iconRes.exists():
        resIcon = DEF_ICON_PATH.format(iconName)
        log.warning('Deprecated format, iconName %s-1.png does not match with file name %s', iconName, resIcon)
        return resIcon
    return backport.image(iconRes())