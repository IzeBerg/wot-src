import typing
from hints_common.battle import manager
from hints.battle.schemas.base import clientHintSchema
if typing.TYPE_CHECKING:
    from hints.battle.schemas.base import CHMType
SCHEMA_TAG = 'clientSchema'

def init():
    manager.init(schemaTag=SCHEMA_TAG, defaultSchema=clientHintSchema)


def get():
    return manager.get()