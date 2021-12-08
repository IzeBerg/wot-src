from HangarPoster import HangarPoster
from NewYearCelebrityEntryObject import NewYearCelebrityEntryObject
from NewYearCelebrityObject import NewYearCelebrityObject
from NewYearJukeboxSelectableObject import NewYearJukeboxSelectableObject
from NewYearSelectableObject import NewYearSelectableObject
from hangar_selectable_objects import HangarSelectableLogic

class WithoutNewYearObjectsSelectableLogic(HangarSelectableLogic):
    __slots__ = ()

    def _filterEntity(self, entity):
        if isinstance(entity, NewYearSelectableObject):
            return False
        if isinstance(entity, (NewYearCelebrityObject, NewYearCelebrityEntryObject)):
            return False
        if isinstance(entity, HangarPoster):
            return False
        if isinstance(entity, NewYearJukeboxSelectableObject):
            return False
        return super(WithoutNewYearObjectsSelectableLogic, self)._filterEntity(entity)