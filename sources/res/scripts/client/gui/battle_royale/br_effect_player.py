import logging, BigWorld, CGF, GenericComponents
from helpers import dependency
from gui.battle_control.controllers.progression_ctrl import IProgressionListener
from gui.battle_control.view_components import IViewComponentsCtrlListener
from skeletons.dynamic_objects_cache import IBattleDynamicObjectsCache
from skeletons.gui.battle_session import IBattleSessionProvider
_logger = logging.getLogger(__name__)

class BRUpgradeEffectPlayer(IProgressionListener, IViewComponentsCtrlListener):
    __dynObjectsCache = dependency.descriptor(IBattleDynamicObjectsCache)
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(BRUpgradeEffectPlayer, self).__init__()
        self.__effectConfig = None
        self.__currentLevel = 0
        return

    def detachedFromCtrl(self, ctrlID):
        self.__effectConfig = None
        return

    def updateData(self, arenaLevelData):
        self.__currentLevel = arenaLevelData.level

    def setVehicleVisualChangingFinished(self, vehicleID):
        self.__playEffect(vehicleID)

    def __playEffect(self, vehicleID):
        if self.__currentLevel > 1:
            vehicle = BigWorld.entities.get(vehicleID)
            if vehicle:
                config = self.__dynObjectsCache.getConfig(self.__sessionProvider.arenaVisitor.getArenaGuiType()).getVehicleUpgradeEffect().effectDescr
                gameObject = CGF.GameObject(vehicle.appearance.spaceID)
                gameObject.createComponent(GenericComponents.HierarchyComponent, vehicle.appearance.gameObject)
                gameObject.createComponent(GenericComponents.ParticleComponent, config.path, config.rate, True)
                gameObject.createComponent(GenericComponents.TransformComponent, config.offset)
                gameObject.activate()
                gameObject.transferOwnershipToWorld()
            else:
                _logger.warning('Unable to get vehicle by id %s', vehicleID)