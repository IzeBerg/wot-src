import ArenaType
from account_helpers.gameplay_ctx import ENABLED_ARENA_GAMEPLAY_NAMES, ENABLED_ARENA_EPIC_NAMES
from constants import PREBATTLE_TYPE, IS_CHINA
from debug_utils import LOG_ERROR, LOG_CURRENT_EXCEPTION
from gui.Scaleform.daapi.view.lobby.trainings import formatters
from gui.Scaleform.daapi.view.meta.TrainingWindowMeta import TrainingWindowMeta
from gui.prb_control import prbEntityProperty
from gui.prb_control.prb_getters import getTrainingBattleRoundLimits
from gui.shared import events, EVENT_BUS_SCOPE
from helpers import dependency
from helpers import i18n
from gui.impl import backport
from gui.impl.gen import R
from skeletons.gui.shared import IItemsCache

class ArenasCache(object):

    def __init__(self, allowedOnlyGpNames=None, excludedGpNames=None):
        self.__cache = []
        self.__allowedOnlyGpNames = allowedOnlyGpNames or ENABLED_ARENA_GAMEPLAY_NAMES
        self.__excludedGpNames = excludedGpNames if excludedGpNames else tuple()
        for arenaTypeID, arenaType in ArenaType.g_cache.iteritems():
            arenaGpName = arenaType.gameplayName
            if arenaType.explicitRequestOnly or arenaGpName in self.__excludedGpNames or arenaGpName not in self.__allowedOnlyGpNames:
                continue
            try:
                nameSuffix = ''
                if arenaGpName != 'ctf':
                    arenaGameplayName = '#arenas:type/%s/%s/name' % (arenaGpName, arenaType.geometryName)
                    if i18n.doesTextExist(arenaGameplayName):
                        nameSuffix = i18n.makeString(arenaGameplayName)
                    else:
                        nameSuffix = i18n.makeString('#arenas:type/%s/name' % arenaGpName)
                self.__cache.append({'label': '%s - %s' % (arenaType.name, nameSuffix) if nameSuffix else arenaType.name, 
                   'name': arenaType.name, 
                   'arenaType': nameSuffix, 
                   'key': arenaTypeID, 
                   'size': arenaType.maxPlayersInTeam, 
                   'time': arenaType.roundLength / 60, 
                   'description': '', 
                   'icon': formatters.getMapIconPath(arenaType)})
            except Exception:
                LOG_ERROR('There is error while reading arenas cache', arenaTypeID, arenaType)
                LOG_CURRENT_EXCEPTION()
                continue

        self.__cache = sorted(self.__cache, key=lambda x: (
         x['label'].lower(), x['name'].lower()))

    @property
    def cache(self):
        return self.__cache


class TrainingSettingsWindow(TrainingWindowMeta):
    itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self, ctx=None):
        super(TrainingSettingsWindow, self).__init__()
        self.__isCreateRequest = ctx.get('isCreateRequest', False)
        self.__settings = ctx.get('settings', None)
        self.__isEpic = self.__settings.getEntityType() == PREBATTLE_TYPE.EPIC_TRAINING
        allowedGpNames = None
        if self.__isEpic:
            allowedGpNames = ENABLED_ARENA_EPIC_NAMES
        self.__arenasCache = ArenasCache(allowedOnlyGpNames=allowedGpNames, excludedGpNames=('rts',
                                                                                             'rts_bootcamp'))
        return

    @prbEntityProperty
    def prbEntity(self):
        return

    def onWindowClose(self):
        self.destroy()

    def _populate(self):
        super(TrainingSettingsWindow, self)._populate()
        self.as_setDataS(self.getInfo(), self.getMapsData())

    def getMapsData(self):
        return self.__arenasCache.cache

    def getInfo(self):
        if not self.__isCreateRequest:
            self.__settings = self.__settings.fetch(self.prbEntity.getSettings())
        if self.itemsCache.isSynced():
            accountAttrs = self.itemsCache.items.stats.attributes
        else:
            accountAttrs = 0
        _, maxBound = getTrainingBattleRoundLimits(accountAttrs)
        if self.__isEpic:
            rTitle = R.strings.menu.epic_training.create.title() if self.__isCreateRequest else R.strings.menu.epic_training.info.settings.title()
        else:
            rTitle = R.strings.menu.training.create.title() if self.__isCreateRequest else R.strings.menu.training.info.settings.title()
        info = {'description': self.__settings.getComment(), 
           'timeout': self.__settings.getRoundLen() / 60, 
           'arena': self.__settings.getArenaTypeID(), 
           'privacy': not self.__settings.isOpened(), 
           'create': self.__isCreateRequest, 
           'wndTitle': backport.text(rTitle), 
           'canMakeOpenedClosed': True, 
           'canChangeComment': not IS_CHINA, 
           'isShowComment': not IS_CHINA, 
           'canChangeArenaTime': not self.__isEpic, 
           'canChangeArena': True, 
           'maxBattleTime': maxBound / 60}
        if not self.__isCreateRequest:
            permissions = self.prbEntity.getPermissions()
            info['canMakeOpenedClosed'] = permissions.canMakeOpenedClosed()
            info['canChangeComment'] = permissions.canChangeComment() and not IS_CHINA
            info['canChangeArena'] = permissions.canChangeArena()
        return info

    def updateTrainingRoom(self, arena, roundLength, isPrivate, comment):
        self.__settings.setArenaTypeID(arena)
        self.__settings.setRoundLen(roundLength * 60)
        self.__settings.setOpened(not isPrivate)
        self.__settings.setComment(comment if not IS_CHINA else '')
        if self.__isEpic:
            eventType = events.TrainingSettingsEvent.UPDATE_EPIC_TRAINING_SETTINGS
        else:
            eventType = events.TrainingSettingsEvent.UPDATE_TRAINING_SETTINGS
        self.fireEvent(events.TrainingSettingsEvent(eventType, ctx={'settings': self.__settings}), scope=EVENT_BUS_SCOPE.LOBBY)