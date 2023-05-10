import base64, cPickle
from visual_script.block import Block, InitParam, EDITOR_TYPE, buildStrKeysValue, Meta
from visual_script.misc import ASPECT, errorVScript
from visual_script.slot_types import SLOT_TYPE
from visual_script.type import VScriptType
from debug_utils import LOG_ERROR

class DictionaryMeta(Meta):

    @classmethod
    def blockColor(cls):
        return 11777386

    @classmethod
    def blockCategory(cls):
        return 'Dictionary'

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/python'


ALLOWED_DATA_TYPES = [
 'String', 'Bool', 'Int', 'Float', 'Vehicle']

class Dictionary(VScriptType, dict):

    def __init__(self, storage=None):
        super(Dictionary, self).__init__()
        if storage:
            self.update(storage)

    @classmethod
    def vs_toString(cls, value):
        if value:
            return base64.b64encode(cPickle.dumps(value, -1))
        else:
            return ''

    @classmethod
    def vs_fromString(cls, str_):
        try:
            if str_:
                return cPickle.loads(base64.b64decode(str_))
        except Exception as e:
            LOG_ERROR('[VScript]', 'Error of load Dictionary from string: %s' % e.message)

        return Dictionary()

    @classmethod
    def vs_aspects(cls):
        return [ASPECT.CLIENT, ASPECT.SERVER]

    @classmethod
    def vs_connectionColor(cls):
        return 11777386


class EmptyDictionary(Block, DictionaryMeta):

    def __init__(self, *args, **kwargs):
        super(EmptyDictionary, self).__init__(*args, **kwargs)
        self._res = self._makeDataOutputSlot('res', SLOT_TYPE.DICTIONARY, self._get)

    def _get(self):
        return Dictionary()

    @classmethod
    def blockAspects(cls):
        return [ASPECT.CLIENT, ASPECT.SERVER]


class AddToDictionary(Block, DictionaryMeta):

    def __init__(self, *args, **kwargs):
        super(AddToDictionary, self).__init__(*args, **kwargs)
        valueType, = self._getInitParams()
        self._in = self._makeEventInputSlot('in', self._exec)
        self._dict = self._makeDataInputSlot('dict', SLOT_TYPE.DICTIONARY)
        self._key = self._makeDataInputSlot('key', SLOT_TYPE.STR)
        self._value = self._makeDataInputSlot('value', valueType)
        self._override = self._makeDataInputSlot('override', SLOT_TYPE.BOOL)
        self._out = self._makeEventOutputSlot('out')
        self._res = self._makeDataOutputSlot('res', SLOT_TYPE.DICTIONARY, None)
        return

    def _exec(self):
        res = Dictionary(self._dict.getValue())
        key = self._key.getValue()
        value = self._value.getValue()
        override = self._override.getValue()
        if override or key not in res:
            res[key] = value
        self._res.setValue(res)
        self._out.call()

    @classmethod
    def initParams(cls):
        return [
         InitParam('Value type', SLOT_TYPE.STR, buildStrKeysValue(*ALLOWED_DATA_TYPES), EDITOR_TYPE.STR_KEY_SELECTOR)]

    @classmethod
    def blockAspects(cls):
        return [ASPECT.CLIENT, ASPECT.SERVER]


class GetFromDictionary(Block, DictionaryMeta):

    def __init__(self, *args, **kwargs):
        super(GetFromDictionary, self).__init__(*args, **kwargs)
        valueType, = self._getInitParams()
        self._dict = self._makeDataInputSlot('dict', SLOT_TYPE.DICTIONARY)
        self._key = self._makeDataInputSlot('key', SLOT_TYPE.STR)
        self._value = self._makeDataOutputSlot('value', valueType, self._getValue)

    def _getValue(self):
        keyValueStorage = self._dict.getValue()
        key = self._key.getValue()
        if key in keyValueStorage:
            self._value.setValue(keyValueStorage[key])
        else:
            errorVScript(self, ('Key {} is missing in the Dictionary').format(key))

    @classmethod
    def initParams(cls):
        return [
         InitParam('Value type', SLOT_TYPE.STR, buildStrKeysValue(*ALLOWED_DATA_TYPES), EDITOR_TYPE.STR_KEY_SELECTOR)]

    @classmethod
    def blockAspects(cls):
        return [ASPECT.CLIENT, ASPECT.SERVER]