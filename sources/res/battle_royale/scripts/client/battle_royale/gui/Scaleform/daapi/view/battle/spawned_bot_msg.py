import logging, BigWorld
from gui.Scaleform.daapi.view.common.battle_royale.br_helpers import canVehicleSpawnBot
from battle_royale.gui.battle_control.controllers.progression_ctrl import IProgressionListener
from gui.battle_control.view_components import IViewComponentsCtrlListener
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
_logger = logging.getLogger(__name__)

class SpawnedBotMsgPlayerMsgs(IProgressionListener, IViewComponentsCtrlListener):
    SPAWNED_BOT_DESTROYED_ID = 'SPAWNED_BOT_DESTROYED'
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(SpawnedBotMsgPlayerMsgs, self).__init__()
        self.__initialized = False
        self.__started = False

    def setVehicleChanged(self, vehicle, newModuleIntCD, vehicleRecreated):
        if not self.__initialized and 'observer' not in vehicle.descriptor.type.tags:
            self.__initialized = True
            self.__started = canVehicleSpawnBot(vehicle.name)
            if self.__started:
                arena = self.__sessionProvider.arenaVisitor.getArenaSubscription()
                if arena:
                    arena.onVehicleKilled += self.__onArenaVehicleKilled
                else:
                    _logger.error("'%s' cannot subscribe to arena events because arena is not ready yet or already destroyed", SpawnedBotMsgPlayerMsgs.__name__)
            else:
                _logger.info('Vehicle can not spawn bots, that is why no need to initialize %s', self)

    def detachedFromCtrl(self, ctrlID):
        super(SpawnedBotMsgPlayerMsgs, self).detachedFromCtrl(ctrlID)
        if self.__started:
            arena = self.__sessionProvider.arenaVisitor.getArenaSubscription()
            if arena:
                arena.onVehicleKilled -= self.__onArenaVehicleKilled

    def __onArenaVehicleKilled(self, targetID, attackerID, equipmentID, reason, numVehiclesAffected):
        killedVehicle = BigWorld.entities.get(targetID)
        if killedVehicle is None:
            return
        else:
            playerVehicleId = self.__sessionProvider.getArenaDP().getPlayerVehicleID(True)
            if killedVehicle.getMasterVehID() == playerVehicleId:
                vehicleName = killedVehicle.typeDescriptor.name.split(':')[1]
                msgStr = ('').join((vehicleName, '_DESTROYED'))
                self.__sessionProvider.shared.messages.onShowPlayerMessageByKey(msgStr)
            return