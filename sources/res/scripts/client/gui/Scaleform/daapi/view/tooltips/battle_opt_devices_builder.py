from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import battle_opt_devices
from gui.shared.tooltips import contexts
from gui.shared.tooltips.builders import DataBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.BATTLE_OPT_DEVICE, TOOLTIPS_CONSTANTS.BATTLE_OPT_DEVICE_UI, battle_opt_devices.BattleOptDeviceTooltipData(contexts.ToolTipContext(None))),)