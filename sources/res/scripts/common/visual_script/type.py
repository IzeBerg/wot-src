from inspect import getmembers
from enumerations import Enumeration
from misc import EDITOR_TYPE, ASPECT
from typing import Any, List

class VScriptType(object):

    @classmethod
    def slotType(cls):
        return cls.vs_pyType().__name__

    @classmethod
    def vs_pyType(cls):
        return cls

    @classmethod
    def vs_name(cls):
        return cls.slotType() + 'T'

    @classmethod
    def vs_aspects(cls):
        return ASPECT.ALL

    @classmethod
    def vs_editor(cls):
        return EDITOR_TYPE.NONE

    @classmethod
    def vs_equals(cls, a, b):
        return a == b

    @classmethod
    def vs_toString(cls, value):
        return ''

    @classmethod
    def vs_fromString(cls, str_):
        return

    @classmethod
    def vs_connectionColor(cls):
        return 7189746

    @classmethod
    def vs_iconConnected(cls):
        return ':vse/slots/default_connected'

    @classmethod
    def vs_iconDisconnected(cls):
        return ':vse/slots/default_disconnected'


class VScriptEnum(object):

    @classmethod
    def slotType(cls):
        return cls.vs_enum().__name__

    @classmethod
    def vs_enum(cls):
        return cls

    @classmethod
    def _vs_collectEnumEntries(cls):
        entriesData = {}
        if isinstance(cls.vs_enum(), Enumeration):
            enum = cls.vs_enum()
            for item in enum.all():
                entriesData[item.name()] = item.index()

        else:
            for name, member in getmembers(cls.vs_enum()):
                if not name.startswith('_') and isinstance(member, int):
                    entriesData[name] = member

        return entriesData

    @classmethod
    def vs_name(cls):
        return cls.slotType() + 'T'

    @classmethod
    def vs_aspects(cls):
        return ASPECT.ALL