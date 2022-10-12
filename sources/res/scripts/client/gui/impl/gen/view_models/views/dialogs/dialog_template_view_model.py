from frameworks.wulf import Array
from gui.impl.gen import R
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.dialogs.dialog_focus_view_model import DialogFocusViewModel
from gui.impl.gen.view_models.views.dialogs.dialog_template_button_view_model import DialogTemplateButtonViewModel
from gui.impl.gen.view_models.views.dialogs.dialog_template_place_holder_view_model import DialogTemplatePlaceHolderViewModel

class DialogTemplateViewModel(ViewModel):
    __slots__ = ('onButtonClicked', 'onCloseClicked')
    DEFAULT = 'default'
    ESCAPE = 'escape'

    def __init__(self, properties=6, commands=2):
        super(DialogTemplateViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def focus(self):
        return self._getViewModel(0)

    @staticmethod
    def getFocusType():
        return DialogFocusViewModel

    def getButtons(self):
        return self._getArray(1)

    def setButtons(self, value):
        self._setArray(1, value)

    @staticmethod
    def getButtonsType():
        return DialogTemplateButtonViewModel

    def getPlaceHolders(self):
        return self._getArray(2)

    def setPlaceHolders(self, value):
        self._setArray(2, value)

    @staticmethod
    def getPlaceHoldersType():
        return DialogTemplatePlaceHolderViewModel

    def getBackground(self):
        return self._getResource(3)

    def setBackground(self, value):
        self._setResource(3, value)

    def getDimmerAlpha(self):
        return self._getReal(4)

    def setDimmerAlpha(self, value):
        self._setReal(4, value)

    def getDisplayFlags(self):
        return self._getArray(5)

    def setDisplayFlags(self, value):
        self._setArray(5, value)

    @staticmethod
    def getDisplayFlagsType():
        return str

    def _initialize(self):
        super(DialogTemplateViewModel, self)._initialize()
        self._addViewModelProperty('focus', DialogFocusViewModel())
        self._addArrayProperty('buttons', Array())
        self._addArrayProperty('placeHolders', Array())
        self._addResourceProperty('background', R.invalid())
        self._addRealProperty('dimmerAlpha', 0.0)
        self._addArrayProperty('displayFlags', Array())
        self.onButtonClicked = self._addCommand('onButtonClicked')
        self.onCloseClicked = self._addCommand('onCloseClicked')