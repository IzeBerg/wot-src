import typing
from collections import Counter, namedtuple
from constants import IS_EDITOR
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.gui_items.gui_item import HasStrCD
from items.components.c11n_constants import ApplyArea, CustomizationType, MAX_PROJECTION_DECALS, CustomizationDisplayType
from items.customizations import parseOutfitDescr, CustomizationOutfit
from items.vehicles import makeIntCompactDescrByID, getItemByCompactDescr, VehicleDescr
from shared_utils import isEmpty
from soft_exception import SoftException
from vehicle_outfit.containers import OutfitContainer, MultiSlot, SizableMultiSlot, ProjectionDecalsMultiSlot
from vehicle_systems.tankStructure import TankPartIndexes
if typing.TYPE_CHECKING:
    from vehicle_outfit.containers import SlotData

class Area(TankPartIndexes):
    MISC = 4
    TANK_PARTS = TankPartIndexes.ALL
    ALL = TankPartIndexes.ALL + (MISC,)


ANCHOR_TYPE_TO_SLOT_TYPE_MAP = {'inscription': GUI_ITEM_TYPE.INSCRIPTION, 
   'player': GUI_ITEM_TYPE.EMBLEM, 
   'paint': GUI_ITEM_TYPE.PAINT, 
   'camouflage': GUI_ITEM_TYPE.CAMOUFLAGE, 
   'projectionDecal': GUI_ITEM_TYPE.PROJECTION_DECAL, 
   'style': GUI_ITEM_TYPE.STYLE, 
   'effect': GUI_ITEM_TYPE.MODIFICATION}
SLOT_TYPE_TO_ANCHOR_TYPE_MAP = {v:k for k, v in ANCHOR_TYPE_TO_SLOT_TYPE_MAP.iteritems()}
SLOT_TYPES = tuple(slotType for slotType in SLOT_TYPE_TO_ANCHOR_TYPE_MAP)
EditableStyleDiff = namedtuple('EditableStyleDiff', ('applied', 'removed'))

def scaffold():
    return (
     OutfitContainer(areaID=Area.CHASSIS, slots=(
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.PAINT,), regions=ApplyArea.CHASSIS_PAINT_REGIONS),)),
     OutfitContainer(areaID=Area.HULL, slots=(
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.PAINT,), regions=ApplyArea.HULL_PAINT_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.CAMOUFLAGE,), regions=ApplyArea.HULL_CAMOUFLAGE_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.EMBLEM,), regions=ApplyArea.HULL_EMBLEM_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.INSCRIPTION, GUI_ITEM_TYPE.PERSONAL_NUMBER), regions=ApplyArea.HULL_INSCRIPTION_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.INSIGNIA,), regions=ApplyArea.HULL_INSIGNIA_REGIONS))),
     OutfitContainer(areaID=Area.TURRET, slots=(
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.PAINT,), regions=ApplyArea.TURRET_PAINT_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.CAMOUFLAGE,), regions=ApplyArea.TURRET_CAMOUFLAGE_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.EMBLEM,), regions=ApplyArea.TURRET_EMBLEM_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.INSCRIPTION, GUI_ITEM_TYPE.PERSONAL_NUMBER), regions=ApplyArea.TURRET_INSCRIPTION_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.INSIGNIA,), regions=ApplyArea.TURRET_INSIGNIA_REGIONS))),
     OutfitContainer(areaID=Area.GUN, slots=(
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.PAINT,), regions=ApplyArea.GUN_PAINT_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.CAMOUFLAGE,), regions=ApplyArea.GUN_CAMOUFLAGE_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.EMBLEM,), regions=ApplyArea.GUN_EMBLEM_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.INSCRIPTION, GUI_ITEM_TYPE.PERSONAL_NUMBER), regions=ApplyArea.GUN_INSCRIPTION_REGIONS),
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.INSIGNIA,), regions=ApplyArea.GUN_INSIGNIA_REGIONS))),
     OutfitContainer(areaID=Area.MISC, slots=(
      MultiSlot(slotTypes=(
       GUI_ITEM_TYPE.MODIFICATION,), regions=ApplyArea.MODIFICATION_REGIONS),
      ProjectionDecalsMultiSlot(slotTypes=(
       GUI_ITEM_TYPE.PROJECTION_DECAL,), regions=[], limit=MAX_PROJECTION_DECALS),
      SizableMultiSlot(slotTypes=(
       GUI_ITEM_TYPE.SEQUENCE,), regions=[]),
      SizableMultiSlot(slotTypes=(
       GUI_ITEM_TYPE.ATTACHMENT,), regions=[]))))


REGIONS_BY_SLOT_TYPE = {container.getAreaID():{slotType:slot.getRegions() for slot in container.slots() for slotType in slot.getTypes()} for container in scaffold()}

class Outfit(HasStrCD):
    __slots__ = ('_id', '_styleDescr', '_containers', '_vehicleCD', '__itemsCounter',
                 '__styleProgressionLevel')

    def __init__(self, strCompactDescr=None, component=None, vehicleCD='', vehicleType=None):
        super(Outfit, self).__init__(strCompactDescr)
        self._containers = {}
        self._vehicleCD = vehicleCD
        if strCompactDescr is not None and component is not None:
            raise SoftException("'strCompactDescr' and 'component' arguments are mutually exclusive!")
        if strCompactDescr:
            component = parseOutfitDescr(strCompactDescr)
        else:
            if component is None:
                component = CustomizationOutfit()
            self._id = component.styleId
            self.__styleProgressionLevel = component.styleProgressionLevel
            if self._id:
                intCD = makeIntCompactDescrByID('customizationItem', CustomizationType.STYLE, self._id)
                self._styleDescr = getItemByCompactDescr(intCD)
            else:
                self._styleDescr = None
            self._construct(vehicleType=vehicleType)
            for container in self._containers.itervalues():
                container.unpack(component)

        self.__itemsCounter = None
        self.invalidate()
        return

    def __str__(self):
        result = ('Outfit (vehicleCD={}, strCD={}):').format(self._vehicleCD, self.pack().makeCompDescr())
        containers = ('\n').join(map(str, self.containers()))
        if containers:
            result += '\n' + containers
        return result

    def _construct(self, vehicleType=None):
        for container in scaffold():
            self._containers[container.getAreaID()] = container

        if not self.vehicleCD:
            return
        else:
            if IS_EDITOR and vehicleType is not None:
                vehicleDescriptor = vehicleType
            else:
                vehicleDescriptor = VehicleDescr(compactDescr=self.vehicleCD)
            projDecalType = SLOT_TYPE_TO_ANCHOR_TYPE_MAP[GUI_ITEM_TYPE.PROJECTION_DECAL]
            areasAnchors = ((anchor for anchor in vehicleDescriptor.chassis.slotsAnchors), (anchor for anchor in vehicleDescriptor.hull.slotsAnchors), (anchor for anchor in vehicleDescriptor.turret.slotsAnchors), (anchor for anchor in vehicleDescriptor.gun.slotsAnchors))
            projDecalRegions = [ anchor.slotId for areaAnchors in areasAnchors for anchor in areaAnchors if anchor.type == projDecalType ]
            projectionDeclasMultiSlot = ProjectionDecalsMultiSlot(slotTypes=(
             GUI_ITEM_TYPE.PROJECTION_DECAL,), regions=projDecalRegions, limit=MAX_PROJECTION_DECALS)
            self.misc.setSlotFor(GUI_ITEM_TYPE.PROJECTION_DECAL, projectionDeclasMultiSlot)
            return

    def pack(self):
        component = CustomizationOutfit()
        for container in self._containers.itervalues():
            container.pack(component)

        component.styleId = self._id
        component.styleProgressionLevel = self.__styleProgressionLevel
        return component

    def copy(self):
        return Outfit(component=self.pack(), vehicleCD=self.vehicleCD)

    def diff(self, other):
        self._validateVehicle(other)
        result = Outfit(vehicleCD=self.vehicleCD)
        for areaID in self._containers.iterkeys():
            acont = self.getContainer(areaID)
            bcont = other.getContainer(areaID)
            result.setContainer(areaID, acont.diff(bcont))

        result.invalidateItemsCounter()
        return result

    def patch(self, diff):
        result = self.discard(diff)
        result = result.adjust(diff)
        return result

    def discard(self, other):
        self._validateVehicle(other)
        result = self.copy()
        for areaID in self._containers.iterkeys():
            acont = self.getContainer(areaID)
            bcont = other.getContainer(areaID)
            result.setContainer(areaID, acont.discard(bcont))

        result.invalidateItemsCounter()
        return result

    def adjust(self, other):
        self._validateVehicle(other)
        result = self.copy()
        self.__styleProgressionLevel = other.progressionLevel
        for areaID in self._containers.iterkeys():
            acont = self.getContainer(areaID)
            bcont = other.getContainer(areaID)
            result.setContainer(areaID, acont.adjust(bcont))

        result.invalidateItemsCounter()
        return result

    def isEqual(self, other):
        if self.id != other.id:
            return False
        if self.progressionLevel != other.progressionLevel:
            return False
        return self.diff(other).isEmpty() and other.diff(self).isEmpty()

    def getContainer(self, areaID):
        return self._containers.get(areaID)

    def setContainer(self, areaID, container):
        self._containers[areaID] = container

    def has(self, item):
        return any(item.intCD == intCD for intCD in self.items())

    @property
    def vehicleCD(self):
        return self._vehicleCD

    @property
    def id(self):
        return self._id

    @property
    def style(self):
        return self._styleDescr

    @property
    def hull(self):
        return self.getContainer(Area.HULL)

    @property
    def chassis(self):
        return self.getContainer(Area.CHASSIS)

    @property
    def turret(self):
        return self.getContainer(Area.TURRET)

    @property
    def gun(self):
        return self.getContainer(Area.GUN)

    @property
    def misc(self):
        return self.getContainer(Area.MISC)

    @property
    def modelsSet(self):
        if self._styleDescr:
            return self._styleDescr.modelsSet
        return ''

    @property
    def attachments(self):
        return self.misc.slotFor(GUI_ITEM_TYPE.ATTACHMENT)

    @property
    def itemsCounter(self):
        if self.__itemsCounter is None:
            self.invalidateItemsCounter()
        return self.__itemsCounter

    @property
    def progressionLevel(self):
        return self.__styleProgressionLevel

    def setProgressionLevel(self, value):
        self.__styleProgressionLevel = value

    def containers(self):
        for container in self._containers.itervalues():
            yield container

    def items(self):
        for container in self._containers.itervalues():
            for slot in container.slots():
                for item in slot.values():
                    yield item

    def itemsFull(self):
        for container in self._containers.itervalues():
            for slot in container.slots():
                for regionIdx in range(slot.capacity()):
                    slotData = slot.getSlotData(regionIdx)
                    if slotData and slotData.intCD:
                        yield (
                         slotData.intCD, slotData.component, regionIdx, container, slot)

    def slotsData(self):
        for container in self._containers.itervalues():
            for slot in container.slots():
                for regionIdx in range(slot.capacity()):
                    slotData = slot.getSlotData(regionIdx)
                    if slotData and slotData.intCD:
                        yield slotData

    def slots(self):
        for container in self._containers.itervalues():
            for slot in container.slots():
                yield slot

    def customizationDisplayType(self):
        if self._styleDescr:
            return self._styleDescr.customizationDisplayType
        itemsCustomizationDisplayType = [ getItemByCompactDescr(intCD).customizationDisplayType for intCD in self.items() ]
        if itemsCustomizationDisplayType:
            return max(itemsCustomizationDisplayType)
        return CustomizationDisplayType.HISTORICAL

    def isEmpty(self):
        return isEmpty(self.items())

    def removePreview(self):
        for container in self._containers.itervalues():
            container.removePreview()

        self.invalidate()

    def clear(self):
        for container in self._containers.itervalues():
            container.clear()

    def invalidate(self):
        for container in self._containers.itervalues():
            container.invalidate()

        self.invalidateItemsCounter()

    def invalidateItemsCounter(self):
        self.__itemsCounter = Counter(slotData.intCD for slotData in self.slotsData() if not slotData.component.preview)

    def _validateVehicle(self, other):
        if not self.vehicleCD or not other.vehicleCD or VehicleDescr(compactDescr=self.vehicleCD).type.compactDescr != VehicleDescr(compactDescr=other.vehicleCD).type.compactDescr:
            raise SoftException("Outfit's vehicleDescriptors are different")