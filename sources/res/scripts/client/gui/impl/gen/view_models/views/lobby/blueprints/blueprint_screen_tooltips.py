from frameworks.wulf import ViewModel

class BlueprintScreenTooltips(ViewModel):
    __slots__ = ()
    TOOLTIP_XP_DISCOUNT = 'BLUEPRINTS_TOOLTIP_XP_DISCOUNT'
    TOOLTIP_BLUEPRINT = 'TOOLTIP_BLUEPRINT'
    TOOLTIP_BLUEPRINT_ITEM_PLACE = 'TOOLTIP_BLUEPRINT_ITEM_PLACE'
    TOOLTIP_BLUEPRINT_CONVERT_COUNT = 'TOOLTIP_BLUEPRINT_CONVERT_COUNT'

    def __init__(self, properties=0, commands=0):
        super(BlueprintScreenTooltips, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BlueprintScreenTooltips, self)._initialize()