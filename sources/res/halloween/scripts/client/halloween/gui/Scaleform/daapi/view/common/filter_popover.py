from gui.Scaleform import getButtonsAssetPath
from gui.Scaleform.daapi.view.common.filter_contexts import FilterSetupContext
from gui.Scaleform.daapi.view.common.filter_popover import TankCarouselFilterPopover
from gui.impl.gen import R
from gui.impl import backport
from gui.shared.utils.functions import makeTooltip
_EVENT_FILTER_INDEX = 1
_EVENT_FILTER_ENTRY = 'event'

class HW22CarouselFilterPopover(TankCarouselFilterPopover):

    def _getInitialVO(self, filters, xpRateMultiplier):
        dataVO = super(HW22CarouselFilterPopover, self)._getInitialVO(filters, xpRateMultiplier)
        filterCtx = FilterSetupContext(asset='hw23_event_toggle', ctx={'level1': 'VIII', 
           'level2': 'VIII'})
        tooltipRes = R.strings.tank_carousel_filter.tooltip.dyn(_EVENT_FILTER_ENTRY)
        dataVO['progressionsSectionVisible'] = False
        dataVO['specials'][_EVENT_FILTER_INDEX] = {'value': getButtonsAssetPath(filterCtx.asset or _EVENT_FILTER_ENTRY), 
           'tooltip': makeTooltip(backport.text(tooltipRes.header()) if tooltipRes else '', backport.text(tooltipRes.body(), **filterCtx.ctx)) if tooltipRes else '', 
           'selected': filters.get(_EVENT_FILTER_ENTRY, False), 
           'enabled': True}
        return dataVO

    @classmethod
    def _getBaseSpecialSection(cls):
        return ['favorite', 'event', 'premium', 'elite']

    @classmethod
    def _generateMapping(cls, hasRented, hasEvent, hasRoles, **kwargs):
        return super(HW22CarouselFilterPopover, cls)._generateMapping(hasRented, False, hasRoles, **kwargs)