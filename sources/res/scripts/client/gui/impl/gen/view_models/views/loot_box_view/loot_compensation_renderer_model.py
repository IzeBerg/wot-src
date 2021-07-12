from gui.impl.gen.view_models.views.loot_box_view.loot_animated_renderer_model import LootAnimatedRendererModel

class LootCompensationRendererModel(LootAnimatedRendererModel):
    __slots__ = ()

    def __init__(self, properties=23, commands=0):
        super(LootCompensationRendererModel, self).__init__(properties=properties, commands=commands)

    def getIconFrom(self):
        return self._getString(14)

    def setIconFrom(self, value):
        self._setString(14, value)

    def getLabelBeforeStr(self):
        return self._getString(15)

    def setLabelBeforeStr(self, value):
        self._setString(15, value)

    def getIconBefore(self):
        return self._getString(16)

    def setIconBefore(self, value):
        self._setString(16, value)

    def getIconAfter(self):
        return self._getString(17)

    def setIconAfter(self, value):
        self._setString(17, value)

    def getLabelBefore(self):
        return self._getString(18)

    def setLabelBefore(self, value):
        self._setString(18, value)

    def getLabelAfter(self):
        return self._getString(19)

    def setLabelAfter(self, value):
        self._setString(19, value)

    def getBonusName(self):
        return self._getString(20)

    def setBonusName(self, value):
        self._setString(20, value)

    def getCountBefore(self):
        return self._getNumber(21)

    def setCountBefore(self, value):
        self._setNumber(21, value)

    def getLabelAlignAfter(self):
        return self._getString(22)

    def setLabelAlignAfter(self, value):
        self._setString(22, value)

    def _initialize(self):
        super(LootCompensationRendererModel, self)._initialize()
        self._addStringProperty('iconFrom', '')
        self._addStringProperty('labelBeforeStr', '')
        self._addStringProperty('iconBefore', '')
        self._addStringProperty('iconAfter', '')
        self._addStringProperty('labelBefore', '')
        self._addStringProperty('labelAfter', '')
        self._addStringProperty('bonusName', '')
        self._addNumberProperty('countBefore', 1)
        self._addStringProperty('labelAlignAfter', 'center')