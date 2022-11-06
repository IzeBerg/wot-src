import BigWorld
from gui.Scaleform.daapi.view.meta.MapsTrainingPrebattleTimerMeta import MapsTrainingPrebattleTimerMeta
from gui.impl import backport
from gui.impl.gen import R
from helpers import dependency, isPlayerAvatar
from items import vehicles
from maps_training_common.maps_training_constants import VEHICLE_CLASSES_ORDER
from skeletons.gui.battle_session import IBattleSessionProvider
from skeletons.gui.game_control import IMapsTrainingController
from vehicle_systems.stricted_loading import makeCallbackWeak
from skeletons.account_helpers.settings_core import ISettingsCore
from account_helpers.settings_core.settings_constants import OnceOnlyHints
from maps_training_common.maps_training_constants import SCENARIO_INDEXES
from PlayerEvents import g_playerEvents
import ArenaType
_VOICEOVERS = ('vo_mt_loading_first_battle', 'vo_mt_loading_next_battle')

class MapsTrainingPreBattleTimer(MapsTrainingPrebattleTimerMeta):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)
    mapsTrainingController = dependency.descriptor(IMapsTrainingController)
    settingsCore = dependency.descriptor(ISettingsCore)

    def __init__(self):
        super(MapsTrainingPreBattleTimer, self).__init__()
        self.__playerClass = None
        self.__playerTeam = None
        return

    def _populate(self):
        super(MapsTrainingPreBattleTimer, self)._populate()
        if not isPlayerAvatar():
            return
        playerVehicle = self.sessionProvider.arenaVisitor.vehicles.getVehicleInfo(BigWorld.player().playerVehicleID)
        self.__playerClass = vehicles.getVehicleClassFromVehicleType(playerVehicle['vehicleType'].type)
        self.__playerTeam = playerVehicle['team']
        mapName = self.sessionProvider.arenaVisitor.type.getGeometryName()
        strings = R.strings.maps_training
        scenarioIndex = SCENARIO_INDEXES[(self.__playerTeam, self.__playerClass)]
        self.as_setSideS(backport.text(strings.prebattle.scenario(), map=backport.text(R.strings.arenas.dyn(('c_{}').format(mapName)).name()), scenario=backport.text(strings.scenarioNum()).format(scenario=scenarioIndex), vehicleType=backport.text(strings.vehicleType.dyn(self.__playerClass)())))
        self.mapsTrainingController.requestInitialDataFromServer(makeCallbackWeak(self.__setGoalsData))

    def __setGoalsData(self):
        typeID = self.sessionProvider.arenaVisitor.type.getID()
        _, geometryID = ArenaType.parseTypeID(typeID)
        mapScenarios = self.mapsTrainingController.getConfig()['scenarios'][geometryID]
        goals = mapScenarios[self.__playerTeam][self.__playerClass]['goals']
        text = backport.text(R.strings.maps_training.prebattle.targets(), count=sum(goals.values()))
        self.as_updateS([ {'vehClass': vehCls, 'total': goals[vehCls]} for vehCls in VEHICLE_CLASSES_ORDER ], text)
        player = BigWorld.player()
        if not player.userSeesWorld():
            g_playerEvents.onAvatarReady += self.__onAvatarReady
        else:
            self.__playSoundNotification()

    def __onAvatarReady(self):
        g_playerEvents.onAvatarReady -= self.__onAvatarReady
        self.__playSoundNotification()

    def __playSoundNotification(self):
        player = BigWorld.player()
        settings = self.settingsCore.serverSettings
        if hasattr(player, 'soundNotifications'):
            if player.soundNotifications is not None:
                player.soundNotifications.play(_VOICEOVERS[int(settings.getOnceOnlyHintsSetting(OnceOnlyHints.MAPS_TRAINING_NEWBIE_HINT, default=False))])
        return