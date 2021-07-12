from collections import namedtuple
CustomizationTooltipContext = namedtuple('CustomizationTooltipContext', ('itemCD',
                                                                         'vehicleIntCD',
                                                                         'showInventoryBlock',
                                                                         'level',
                                                                         'showOnlyProgressBlock'))
CustomizationTooltipContext.__new__.__defaults__ = (
 -1, -1, False, -1, False)