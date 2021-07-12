from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl.backport import createTooltipData
from gui.impl.gen.view_models.views.lobby.blueprints.blueprint_screen_tooltips import BlueprintScreenTooltips

def getBlueprintTooltipData(ttId, itemCD):
    if ttId == BlueprintScreenTooltips.TOOLTIP_BLUEPRINT and itemCD is not None:
        return createTooltipData(isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.BLUEPRINT_FRAGMENT_INFO, specialArgs=[
         int(itemCD)])
    else:
        return