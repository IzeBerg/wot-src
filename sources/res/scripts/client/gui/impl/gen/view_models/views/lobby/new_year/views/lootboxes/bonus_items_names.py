from frameworks.wulf import ViewModel

class BonusItemsNames(ViewModel):
    __slots__ = ()
    TOYS = 'ny24Toys'
    BOX_WITH_TOYS = 'boxWithToys'
    PREMIUM_PLUS = 'premium_plus'
    EXTRA_SLOT = 'ny24:extraSlot'
    VARIADIC_DISCOUNT = 'variadicDiscount'
    VEHICLE = 'vehicles'
    OTHER = 'other'

    def __init__(self, properties=0, commands=0):
        super(BonusItemsNames, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BonusItemsNames, self)._initialize()