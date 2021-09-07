import BigWorld
from block import Meta, Block, InitParam, buildStrKeysValue, EDITOR_TYPE
from constants import IS_CELLAPP, IS_CLIENT
from soft_exception import SoftException
from visual_script.misc import errorVScript
from visual_script.slot_types import SLOT_TYPE, arrayOf

class ArenaMeta(Meta):

    @classmethod
    def blockColor(cls):
        return 10512127

    @classmethod
    def blockCategory(cls):
        return 'Arena'

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/arena'


class GetUDOByNameBase(Block, ArenaMeta):
    _UDOTypes = []

    def __init__(self, *args, **kwargs):
        super(GetUDOByNameBase, self).__init__(*args, **kwargs)
        self._nameType, self._type = self._getInitParams()
        if self._nameType == 'single name':
            self._name = self._makeDataInputSlot('name', SLOT_TYPE.STR)
        elif self._nameType == 'multiple names':
            self._names = self._makeDataInputSlot('names', arrayOf(SLOT_TYPE.STR))
        elif self._nameType == 'any names':
            pass
        else:
            errorVScript(self, 'Unsupported name reference')
        self._UDOs = self._makeDataOutputSlot(self._type + 's', arrayOf(self._type), self._getAll)
        self._firstUDO = self._makeDataOutputSlot('first' + self._type, self._type, self._getFirst)

    @classmethod
    def initParams(cls):
        return [
         InitParam('UDO names', SLOT_TYPE.STR, buildStrKeysValue('single name', 'multiple names', 'any names'), EDITOR_TYPE.STR_KEY_SELECTOR),
         InitParam('UDO type', SLOT_TYPE.STR, buildStrKeysValue(*cls._UDOTypes), EDITOR_TYPE.STR_KEY_SELECTOR)]

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/rubic'

    def captionText(self):
        if self._nameType == 'any names':
            return 'Get UDO'
        else:
            return 'Get UDO By Name'

    def _getAll(self):
        self._UDOs.setValue(self._allValidUDOs())

    def _getFirst(self):
        udos = self._allValidUDOs()
        if udos:
            self._firstUDO.setValue(self._allValidUDOs()[0])
        else:
            raise SoftException("GetUDOByName block can't find a referred UDO by it name")

    def _getUDOsOfType(self, typeName):
        raise SoftException('Using the base GetUDOByNameBase class directly')

    def _allValidUDOs(self):
        allUDOs = self._getUDOsOfType(self._type)
        if self._nameType == 'single name':
            names = [
             self._name.getValue()]
        elif self._nameType == 'multiple names':
            names = self._names.getValue()
        else:
            if self._nameType == 'any names':
                return allUDOs
            else:
                return []

        return [ udo for udo in allUDOs if udo.name in names ]


class GetDataFromStorageBase(Block, ArenaMeta):

    def __init__(self, *args, **kwargs):
        super(GetDataFromStorageBase, self).__init__(*args, **kwargs)
        self.componentName, self._valueType = self._getInitParams()
        self.componentSlot = self._makeDataInputSlot('componentProperty', SLOT_TYPE.STR)
        self.componentSlot.setDefaultValue(self.componentName)
        if self.componentName == 'globalGoal':
            self._keySlot = self._makeDataInputSlot('key', SLOT_TYPE.STR)
        if self._valueType == SLOT_TYPE.STR:
            self._valueSlot = self._makeDataOutputSlot('value', SLOT_TYPE.STR, self._exec)
        elif self._valueType == SLOT_TYPE.INT:
            self._valueSlot = self._makeDataOutputSlot('value', SLOT_TYPE.INT, self._exec)
        elif self._valueType == SLOT_TYPE.FLOAT:
            self._valueSlot = self._makeDataOutputSlot('value', SLOT_TYPE.FLOAT, self._exec)

    @classmethod
    def initParams(cls):
        return [
         InitParam('Component property name', SLOT_TYPE.STR, buildStrKeysValue('globalGoal'), EDITOR_TYPE.STR_KEY_SELECTOR),
         InitParam('Value Types', SLOT_TYPE.STR, buildStrKeysValue(SLOT_TYPE.STR, SLOT_TYPE.FLOAT, SLOT_TYPE.INT), EDITOR_TYPE.STR_KEY_SELECTOR)]

    def _exec(self):
        storage = self.arena.arenaInfo.mapsTrainingStorageComponent
        if self.componentName == 'globalGoal':
            self._valueSlot.setValue(storage.getGlobalGoal(self._keySlot.getValue()))