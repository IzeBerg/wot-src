from block import Block
from slot_types import SLOT_TYPE

class Assert(Block):

    def __init__(self, *args, **kwargs):
        super(Assert, self).__init__(*args, **kwargs)
        self._in = self._makeEventInputSlot('in', Assert._execute)
        self._value = self._makeDataInputSlot('value', SLOT_TYPE.BOOL)
        self._msg = self._makeDataInputSlot('msg', SLOT_TYPE.STR)
        self._out = self._makeEventOutputSlot('out')

    def _execute(self):
        self._out.call()

    @classmethod
    def blockColor(cls):
        return 15023674

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/debug'


class TestCase(Block):

    def __init__(self, *args, **kwargs):
        super(TestCase, self).__init__(*args, **kwargs)
        self._in = self._makeEventInputSlot('in', TestCase._execute)
        self._name = self._makeDataInputSlot('name', SLOT_TYPE.STR)
        self._out = self._makeEventOutputSlot('out')

    def _execute(self):
        self._out.call()

    @classmethod
    def blockColor(cls):
        return 15023674