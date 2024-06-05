import typing
from dog_tags_common.config.common import DEFAULT_GRADE
from dog_tags_common.dog_tags_storage import EMPTY_PROGRESS_RECORD, ProgressRecord
if typing.TYPE_CHECKING:
    from dossiers2 import DossierDescr
    from dog_tags_common.config.dog_tag_framework import ComponentDefinition

def getCoupledDogTagProgress(accDossierDescr, component):
    unlockKey = component.unlockKey
    achievementType, achievementId, _ = unlockKey
    achievementId = int(achievementId)
    if achievementType is None or achievementId is None or accDossierDescr is None or achievementType not in accDossierDescr or achievementId not in accDossierDescr[achievementType]:
        return EMPTY_PROGRESS_RECORD
    return ProgressRecord(accDossierDescr[achievementType][achievementId][0], DEFAULT_GRADE)