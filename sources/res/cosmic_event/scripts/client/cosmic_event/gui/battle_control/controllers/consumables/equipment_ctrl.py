import logging
from enum import Enum
from typing import TYPE_CHECKING
import Event
from constants import EQUIPMENT_STAGES
from cosmic_event_common.cosmic_constants import COSMIC_EVENT_ROCKET_BOOSTER, COSMIC_EVENT_SHIELD, COSMIC_EVENT_VORTEX, COSMIC_EVENT_REPULSOR, COSMIC_EVENT_JUMP, COSMIC_EVENT_MINES
from cosmic_event.cosmic_control_mode import CosmicArcadeMapCaseControlMode
from cosmic_sound import CosmicBattleSounds
from gui.battle_control.controllers.consumables.equipment_ctrl import _VisualScriptItem, _ReplayItem, EquipmentsController, InCooldownError, NotReadyError, EquipmentSound
from gui.shared.system_factory import registerEquipmentItem
from items import vehicles, EQUIPMENT_TYPES
_logger = logging.getLogger(__name__)
if TYPE_CHECKING:
    from typing import Optional
_PREV_STAGE_FOR_SOUND = (EQUIPMENT_STAGES.DEPLOYING,
 EQUIPMENT_STAGES.COOLDOWN, EQUIPMENT_STAGES.SHARED_COOLDOWN,
 EQUIPMENT_STAGES.EXHAUSTED, EQUIPMENT_STAGES.NOT_RUNNING)

class ExtraEquipmentTags(Enum):
    TARGETING = 'targeting'


class _CosmicBaseItem(_VisualScriptItem):
    extraTags = ()

    def canActivate(self, entityName=None, avatar=None):
        canBeActivated, error = super(_CosmicBaseItem, self).canActivate(entityName, avatar)
        if not canBeActivated:
            if isinstance(error, (InCooldownError, NotReadyError)):
                CosmicBattleSounds.Abilities.playNotReady()
        return (
         canBeActivated, error)

    def _soundUpdate(self, prevQuantity, quantity):
        if prevQuantity > quantity and self._stage != self._prevStage:
            if self._stage != EQUIPMENT_STAGES.NOT_RUNNING:
                EquipmentSound.playSound(self._descriptor.compactDescr)
        if self.isReady and self._serverPrevStage in _PREV_STAGE_FOR_SOUND:
            EquipmentSound.playReady(self)

    def activate(self, entityName=None, avatar=None):
        super(_CosmicBaseItem, self).activate(entityName, avatar)
        CosmicBattleSounds.Abilities.playActivated()

    def onElapsed(self):
        pass

    def getTags(self):
        return self.extraTags + tuple(super(_CosmicBaseItem, self).getTags())


class _CosmicEventRocketBoosterItem(_CosmicBaseItem):

    def activate(self, entityName=None, avatar=None):
        super(_CosmicEventRocketBoosterItem, self).activate(entityName, avatar)
        CosmicBattleSounds.Abilities.playBoosterActivated()


class _ReplayCosmicEventRocketBoosterItem(_ReplayItem, _CosmicEventRocketBoosterItem):
    pass


class _CosmicEventAimingItem(_CosmicBaseItem):
    extraTags = (
     ExtraEquipmentTags.TARGETING,)

    def _getAimingControlMode(self):
        return CosmicArcadeMapCaseControlMode


class _ReplayCosmicEventAimingItem(_ReplayItem, _CosmicEventAimingItem):
    pass


class _CosmicEventShieldItem(_CosmicBaseItem):
    pass


class _ReplayCosmicEventShieldItem(_ReplayItem, _CosmicEventShieldItem):
    pass


class _CosmicEventMinesItem(_CosmicBaseItem):

    def activate(self, entityName=None, avatar=None):
        super(_CosmicEventMinesItem, self).activate(entityName, avatar)
        CosmicBattleSounds.Abilities.playMinesDeployed()


class _ReplayCosmicEventMinesItem(_ReplayItem, _CosmicEventMinesItem):
    pass


def registerCosmicEventEquipmentsItems():
    registerEquipmentItem(COSMIC_EVENT_ROCKET_BOOSTER, _CosmicEventRocketBoosterItem, _ReplayCosmicEventRocketBoosterItem)
    registerEquipmentItem(COSMIC_EVENT_SHIELD, _CosmicEventShieldItem, _ReplayCosmicEventShieldItem)
    registerEquipmentItem(COSMIC_EVENT_VORTEX, _CosmicEventAimingItem, _ReplayCosmicEventAimingItem)
    registerEquipmentItem(COSMIC_EVENT_REPULSOR, _CosmicEventAimingItem, _ReplayCosmicEventAimingItem)
    registerEquipmentItem(COSMIC_EVENT_JUMP, _CosmicEventAimingItem, _ReplayCosmicEventAimingItem)
    registerEquipmentItem(COSMIC_EVENT_MINES, _CosmicEventMinesItem, _ReplayCosmicEventMinesItem)


class CosmicEquipmentsController(EquipmentsController):
    _ACCEPTABLE_EQUIPMENT_STATUS = (
     EQUIPMENT_STAGES.READY, EQUIPMENT_STAGES.COOLDOWN,
     EQUIPMENT_STAGES.ACTIVE, EQUIPMENT_STAGES.PREPARING,
     EQUIPMENT_STAGES.UNAVAILABLE)

    def __init__(self, setup):
        super(CosmicEquipmentsController, self).__init__(setup)
        self.onEquipmentRemoved = Event.Event(self._eManager)

    def getOrdinal(self, intCD):
        if intCD not in self._order:
            _logger.warning('Equipment %d, cannot be found in equipment controller. Equipment order %s', intCD, self.getOrderedEquipmentsLayout())
            return None
        else:
            return self._order.index(intCD)

    def setEquipment(self, intCD, quantity, stage, timeRemaining, totalTime, index=0):
        _logger.debug('Equipment added: intCD=%d, quantity=%d, stage=%s, timeRemaining=%d, totalTime=%d, index=%d', intCD, quantity, stage, timeRemaining, totalTime, index)
        item = None
        if not intCD:
            if len(self._order) < self.__equipmentCount:
                self._order.append(0)
                self.onEquipmentAdded(0, None)
        elif intCD in self._equipments:
            item = self._equipments[intCD]
            if quantity == 0:
                item = self._equipments.pop(intCD, None)
                item.onElapsed()
                self._order.remove(intCD)
                self.onEquipmentRemoved(intCD, item)
            else:
                item.update(quantity, stage, timeRemaining, totalTime)
                self.onEquipmentUpdated(intCD, item)
        elif stage in self._ACCEPTABLE_EQUIPMENT_STATUS:
            descriptor = vehicles.getItemByCompactDescr(intCD)
            if descriptor.equipmentType in (EQUIPMENT_TYPES.regular, EQUIPMENT_TYPES.battleAbilities):
                item = self.createItem(descriptor, quantity, stage, timeRemaining, totalTime)
                self._equipments[intCD] = item
                self._order.append(intCD)
                item.updateMapCase()
                self.onEquipmentAdded(intCD, item)
        if item:
            item.setServerPrevStage(None)
        return