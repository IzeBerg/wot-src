from typing import Dict, Type
from .component_bin_deserializer import ComponentBinDeserializer
from .component_bin_serializer import ComponentBinSerializer
from .serializable_component import SerializableComponent, SerializableComponentChildType
__all__ = ('makeCompDescr', 'parseCompDescr')

def makeCompDescr(customizationItem):
    return ComponentBinSerializer().serialize(customizationItem)


def parseCompDescr(CUSTOMIZATION_CLASSES, customizationElementCompDescr):
    return ComponentBinDeserializer(CUSTOMIZATION_CLASSES).decode(customizationElementCompDescr)