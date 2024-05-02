import typing
from dict2model import fields
from cosmic_account_settings import getBattleHintCounter, incrementBattleHintCounter
from hints.battle.schemas.base import ClientHintTextModel, ClientHintModel, CHMLifecycleType, CHMVisualType, CHMSoundType, ClientHintSchema, ClientHintTextSchema, CHMHistoryType
from hints_common.battle.schemas.base import CommonHintContextModel, CommonHintPropsSchema, CommonHintPropsModel
if typing.TYPE_CHECKING:
    from dict2model.extensions.battle_type import BattleTypeModel

class CosmicEventHintTextModel(ClientHintTextModel):
    pass


class CosmicHintPropsModel(CommonHintPropsModel):
    __slots__ = ('showCountdown', 'showLimit')

    def __init__(self, name, scope, component, unique, priority, battleTypes, showCountdown, showLimit):
        super(CosmicHintPropsModel, self).__init__(name=name, scope=scope, component=component, unique=unique, priority=priority, battleTypes=battleTypes)
        self.showCountdown = showCountdown
        self.showLimit = showLimit


class CosmicHintPropsSchema(CommonHintPropsSchema[CosmicHintPropsModel]):

    def __init__(self):
        super(CosmicHintPropsSchema, self).__init__(modelClass=CosmicHintPropsModel)
        self._fields['showCountdown'] = fields.Boolean(required=False, default=True)
        self._fields['showLimit'] = fields.Integer(required=False, default=0)


class CosmicEventHintTextSchema(ClientHintTextSchema[CosmicEventHintTextModel]):

    def __init__(self):
        super(CosmicEventHintTextSchema, self).__init__(checkUnknown=True, modelClass=CosmicEventHintTextModel)


class CosmicEventHintModel(ClientHintModel[(CosmicHintPropsModel, CosmicEventHintTextModel, CHMVisualType, CHMSoundType,
 CHMLifecycleType, CommonHintContextModel, CHMHistoryType)]):

    def validate(self, *args, **kwargs):
        if self.props.showLimit:
            if getBattleHintCounter(self.props.uniqueName) >= self.props.showLimit:
                return False
            incrementBattleHintCounter(self.props.uniqueName)
        return super(CosmicEventHintModel, self).validate(*args, **kwargs)


cosmicHintPropsSchema = CosmicHintPropsSchema()
hintTextSchema = CosmicEventHintTextSchema()
hintSchema = ClientHintSchema[CosmicEventHintModel](propsSchema=cosmicHintPropsSchema, textSchema=hintTextSchema, contextSchema=CommonHintContextModel, modelClass=CosmicEventHintModel)