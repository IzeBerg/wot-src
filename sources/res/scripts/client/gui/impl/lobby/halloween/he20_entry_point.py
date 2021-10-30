from adisp import process
from gui.Scaleform.daapi.view.lobby.event_boards.formaters import formatTimeAndDate
from gui.Scaleform.daapi.view.meta.HE20EntryPointMeta import HE20EntryPointMeta
from gui.impl import backport
from gui.impl.gen import R
from gui.prb_control import prbDispatcherProperty
from gui.prb_control.entities.base.ctx import PrbAction
from gui.prb_control.settings import PREBATTLE_ACTION_NAME
from helpers import dependency
from skeletons.gui.afk_controller import IAFKController
from skeletons.gui.game_event_controller import IGameEventController
from skeletons.gui.server_events import IEventsCache

@dependency.replace_none_kwargs(eventsCache=IEventsCache)
def isHE20EntryPointAvailable(eventsCache=None):
    return eventsCache.isEventEnabled()


class HE20EntryPoint(HE20EntryPointMeta):
    eventsCache = dependency.descriptor(IEventsCache)
    gameEventController = dependency.descriptor(IGameEventController)
    afkController = dependency.descriptor(IAFKController)

    @prbDispatcherProperty
    def prbDispatcher(self):
        return

    def onClick(self):
        self.__doSelectAction(PREBATTLE_ACTION_NAME.EVENT_BATTLE)

    def _populate(self):
        super(HE20EntryPoint, self)._populate()
        self.eventsCache.onSyncCompleted += self.__updateEvent
        self.afkController.onBanUpdated += self.__onBanUpdated
        self.__updateEvent()

    def _dispose(self):
        self.eventsCache.onSyncCompleted -= self.__updateEvent
        self.afkController.onBanUpdated -= self.__onBanUpdated
        super(HE20EntryPoint, self)._dispose()

    @process
    def __doSelectAction(self, actionName):
        yield self.prbDispatcher.doSelectAction(PrbAction(actionName))

    def __updateEvent(self):
        if not self.eventsCache.isEventEnabled():
            self.destroy()
            return
        vehiclesController = self.gameEventController.getVehiclesController()
        totalVehicles = vehiclesController.getAllVehiclesInInventory()
        dailyQuests = sum(vehiclesController.hasDailyQuest(vehCD) for vehCD in totalVehicles)
        timeToEnd = self.eventsCache.getEventFinishTimeLeft()
        info = backport.getTillTimeStringByRClass(timeToEnd, R.strings.tooltips.battleTypes.event)
        if self.afkController.isBanned:
            banMessage = backport.text(R.strings.event.hangar.banner.ban_info(), value=formatTimeAndDate(self.afkController.banExpiryTime))
        else:
            banMessage = ''
        self.as_setDataS({'status': ('{} / {}').format(dailyQuests, len(totalVehicles)), 
           'info': info, 
           'tooltip': '', 
           'specialArgs': [], 'isSpecial': True, 
           'banMessage': banMessage, 
           'isDailiesRemoved': not dailyQuests})

    def __onBanUpdated(self, *_):
        self.__updateEvent()