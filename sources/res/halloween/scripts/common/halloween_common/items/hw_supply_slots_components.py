from items.components.supply_slots_components import EquipmentSlot
from items.vehicles import getItemByCompactDescr

class HWEquipmentSlot(EquipmentSlot):

    def readFromSection(self, section):
        super(HWEquipmentSlot, self).readFromSection(section)
        self.tags = frozenset(section.readString('tags').split())

    def _checkSlotCompatibility(self, parsedCompDescr=None, descr=None):
        item = descr or getItemByCompactDescr(parsedCompDescr)
        eqTags = getattr(item, 'tags', set())
        if self.tags and not eqTags.intersection(self.tags):
            return (False, ('Equipment tags ({}) does not contain any of slot tags ({})').format(eqTags, self.tags))
        return super(HWEquipmentSlot, self)._checkSlotCompatibility(parsedCompDescr, descr)