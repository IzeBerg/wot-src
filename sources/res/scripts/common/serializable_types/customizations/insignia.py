from collections import OrderedDict
from items.components.c11n_constants import ApplyArea
from serialization.field import xmlOnlyIntField, xmlOnlyApplyAreaEnumField
from serialization.serializable_component import SerializableComponent
from wrapped_reflection_framework import ReflectionMetaclass
from ..types import C11nSerializationTypes
__all__ = ('InsigniaComponent', )

class InsigniaComponent(SerializableComponent):
    __metaclass__ = ReflectionMetaclass
    customType = C11nSerializationTypes.INSIGNIA
    fields = OrderedDict((
     (
      'id', xmlOnlyIntField()),
     (
      'appliedTo', xmlOnlyApplyAreaEnumField(ApplyArea.NONE))))
    __slots__ = ('id', 'appliedTo')

    def __init__(self, id=0, appliedTo=ApplyArea.NONE):
        self.id = id
        self.appliedTo = appliedTo
        super(InsigniaComponent, self).__init__()