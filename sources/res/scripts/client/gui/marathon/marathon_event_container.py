import typing
from gui.server_events.event_items import Group, Quest
from gui.game_control.links import URLMacros
from gui.marathon.marathon_constants import MarathonState, MISSION_TAB_FORMAT, AWARD_TOKENS_FORMAT, R_TITLE_TOOLTIP, TOKEN_COUNT_INDEX, ZERO_TIME
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.locale.QUESTS import QUESTS
from gui.Scaleform.locale.TOOLTIPS import TOOLTIPS
from items.vehicles import makeVehicleTypeCompDescrByName

class MarathonEventContainer(object):

    def __init__(self):
        self.prefix = 'event_marathon'
        self.tokenPrefix = 'event_marathon'
        self.urlName = 'marathonUrl'
        self.marathonCompleteUrlAdd = 'overlay/'
        self.vehicleName = ''
        self.suspendPrefix = ':suspend'
        self.completedTokenPostfix = '_PASS'
        self.hangarFlagName = 'flag_italy'
        self.questsInChain = 10
        self.minVehicleLevel = 6
        self.awardTokensPostfix = ('COMPLETE', 'PS_STOP')
        self.showFlagTooltipBottom = True
        self.flagTooltip = TOOLTIPS_CONSTANTS.MARATHON_QUESTS_PREVIEW
        self.disabledFlagTooltip = TOOLTIPS.MARATHON_OFF
        self.marathonTooltipHeader = 'marathonTooltipHeader'
        self.bodyAddInfo = R_TITLE_TOOLTIP.body.addInfo
        self.doesShowRewardScreen = False
        self.doesShowRewardVideo = False
        self.doesShowInPostBattle = True
        self.questsPerStep = 2
        self.isEnabled = False
        self.isAvailable = False
        self.rewardObtained = False
        self.state = MarathonState.UNKNOWN
        self.suspendFlag = False
        self.quest = None
        self.group = None
        self.vehicleID = 0
        self.awardTokens = None
        self.tabTooltip = None
        self.infoBody = None
        self.label = ''
        self.backBtnLabel = ''
        self.tooltips = None
        self.icons = None
        self.urlMacros = URLMacros()
        self._override()
        self._initialize()
        return

    def _initialize(self):
        self.vehicleID = 0 if not self.vehicleName else makeVehicleTypeCompDescrByName(self.vehicleName)
        self.awardTokens = tuple(AWARD_TOKENS_FORMAT.format(self.tokenPrefix, postfix) for postfix in self.awardTokensPostfix)
        self.tabTooltip = getattr(QUESTS, MISSION_TAB_FORMAT.format(self.prefix.upper()), QUESTS.MISSIONS_TAB_MARATHONS)

    def _override(self):
        pass

    def getTimeFromGroupStart(self):
        if self.group:
            return self.group.getTimeFromStartTillNow()
        return ZERO_TIME

    def getGroupStartFinishTime(self):
        if self.group:
            return (self.group.getStartTimeRaw(), self.group.getFinishTimeRaw())
        return (ZERO_TIME, ZERO_TIME)

    def getGroupTimeInterval(self):
        if self.group:
            return (self.group.getStartTimeLeft(), self.group.getFinishTimeLeft())
        return (ZERO_TIME, ZERO_TIME)

    def getQuestTimeInterval(self):
        if self.quest:
            return (self.quest.getStartTimeLeft(), self.quest.getFinishTimeLeft())
        return (ZERO_TIME, ZERO_TIME)

    def getQuestStartFinishTime(self):
        if self.quest:
            return (self.quest.getStartTimeRaw(), self.quest.getFinishTimeRaw())
        return (ZERO_TIME, ZERO_TIME)

    def setQuest(self, quests, currentStep):
        self.suspendFlag = False
        if not quests:
            self.quest = None
            return
        else:
            sortedQuests = sorted(quests.itervalues(), key=lambda quest: quest.getStartTimeLeft())
            for q in quests:
                if self.suspendPrefix in q:
                    self.suspendFlag = True
                    break

            try:
                self.quest = sortedQuests[(currentStep * self.questsPerStep)]
            except IndexError:
                self.quest = sortedQuests[(-1)]

            return

    def setGroup(self, groups):
        if groups:
            sortedGroups = sorted(groups)
            self.group = groups[sortedGroups[0]]
        else:
            self.group = None
        return

    def setState(self, state):
        self.state = state
        self.isEnabled = True
        self.isAvailable = True
        if self.state == MarathonState.SUSPENDED:
            self.isAvailable = False
        if self.state in (MarathonState.UNKNOWN, MarathonState.DISABLED):
            self.isEnabled = False
            self.isAvailable = False

    def setRewardObtained(self, tokens):
        self.rewardObtained = False
        for key in self.awardTokens:
            if key in tokens and tokens[key][TOKEN_COUNT_INDEX] > 0:
                self.rewardObtained = True
                break