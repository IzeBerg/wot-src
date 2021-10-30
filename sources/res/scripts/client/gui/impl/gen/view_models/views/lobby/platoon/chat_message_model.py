from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.platoon.chat_message_part_model import ChatMessagePartModel

class ChatMessageModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(ChatMessageModel, self).__init__(properties=properties, commands=commands)

    @property
    def playerName(self):
        return self._getViewModel(0)

    @property
    def timeStamp(self):
        return self._getViewModel(1)

    @property
    def text(self):
        return self._getViewModel(2)

    def getKey(self):
        return self._getNumber(3)

    def setKey(self, value):
        self._setNumber(3, value)

    def _initialize(self):
        super(ChatMessageModel, self)._initialize()
        self._addViewModelProperty('playerName', ChatMessagePartModel())
        self._addViewModelProperty('timeStamp', ChatMessagePartModel())
        self._addViewModelProperty('text', ChatMessagePartModel())
        self._addNumberProperty('key', 0)