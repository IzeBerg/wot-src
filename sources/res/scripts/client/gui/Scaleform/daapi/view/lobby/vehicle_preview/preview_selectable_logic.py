from ClientSelectableRTSObject import ClientSelectableRTSObject
from ClientSelectableRankedObject import ClientSelectableRankedObject
from hangar_selectable_objects import HangarSelectableLogic

class PreviewSelectableLogic(HangarSelectableLogic):

    def _filterEntity(self, entity):
        isFiltered = super(PreviewSelectableLogic, self)._filterEntity(entity)
        isFiltered = isFiltered and not isinstance(entity, ClientSelectableRankedObject) and not isinstance(entity, ClientSelectableRTSObject)
        return isFiltered