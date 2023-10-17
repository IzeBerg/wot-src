from gui.Scaleform.genConsts.BLOCKS_TOOLTIP_TYPES import BLOCKS_TOOLTIP_TYPES
from gui.Scaleform.genConsts.ICON_TEXT_FRAMES import ICON_TEXT_FRAMES
from gui.Scaleform.locale.RES_ICONS import RES_ICONS
from gui.impl import backport
from gui.impl.gen import R
from gui.prb_control.entities.listener import IGlobalListener
from gui.shared.formatters import text_styles
from gui.shared.gui_items.Vehicle import getTypeBigIconPath
from gui.shared.tooltips import formatters
from gui.shared.tooltips.vehicle import VehicleInfoTooltipData, StatusBlockConstructor, HeaderBlockConstructor, SimplifiedStatsBlockConstructor
from halloween.gui.impl.gen.view_models.views.lobby.widgets.hangar_carousel_vehicle_view_model import VehicleStates
from halloween.gui.impl.lobby import getVehicleState
from halloween.gui.impl.lobby.hw_helpers import isDailyKeyQuestCompleted

class EventVehicleInfoTooltipData(VehicleInfoTooltipData, IGlobalListener):

    def _getCrewIconBlock(self):
        tImg = RES_ICONS.MAPS_ICONS_MESSENGER_ICONCONTACTS
        return [formatters.packImageBlockData(img=tImg, alpha=0)]

    def _packBlocks(self, *args, **kwargs):
        self.item = self.context.buildItem(*args, **kwargs)
        items = []
        vehicle = self.item
        statsConfig = self.context.getStatsConfiguration(vehicle)
        paramsConfig = self.context.getParamsConfiguration(vehicle)
        statusConfig = self.context.getStatusConfiguration(vehicle)
        leftPadding = self._LEFT_PADDING
        rightPadding = self._RIGHT_PADDING
        bottomPadding = 12
        blockTopPadding = -4
        leftRightPadding = formatters.packPadding(left=leftPadding, right=rightPadding)
        blockPadding = formatters.packPadding(left=leftPadding, right=rightPadding, top=blockTopPadding)
        valueWidth = 77
        headerItems = [
         formatters.packBuildUpBlockData(EventHeaderBlockConstructor(vehicle, statsConfig, leftPadding, rightPadding).construct(), padding=leftRightPadding, blockWidth=410),
         formatters.packBuildUpBlockData(self._getCrewIconBlock(), gap=2, layout=BLOCKS_TOOLTIP_TYPES.LAYOUT_HORIZONTAL, align=BLOCKS_TOOLTIP_TYPES.ALIGN_RIGHT, padding=formatters.packPadding(top=34, right=0), blockWidth=20)]
        headerBlockItems = [
         formatters.packBuildUpBlockData(headerItems, layout=BLOCKS_TOOLTIP_TYPES.LAYOUT_HORIZONTAL, padding=formatters.packPadding(bottom=-16))]
        if not isDailyKeyQuestCompleted(vehicle.intCD):
            headerBlockItems.append(formatters.packTextParameterWithIconBlockData(name=text_styles.main(backport.text(R.strings.halloween_tooltips.vehicle.eventBonus())), value='', icon=ICON_TEXT_FRAMES.EVENT_KEY, iconYOffset=-2, valueWidth=valueWidth - 8, nameOffset=8, gap=0, padding=formatters.packPadding(left=2, top=3, bottom=3)))
        items.append(formatters.packBuildUpBlockData(headerBlockItems, gap=-4, padding=formatters.packPadding(bottom=-12)))
        simplifiedStatsBlock = SimplifiedStatsBlockConstructor(vehicle, paramsConfig, leftPadding, rightPadding).construct()
        if simplifiedStatsBlock:
            items.append(formatters.packBuildUpBlockData(simplifiedStatsBlock, gap=-4, linkage=BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_WHITE_BG_LINKAGE, padding=leftRightPadding))
        if not vehicle.isRotationGroupLocked:
            statusBlock, operationError, _ = EventStatusBlockConstructor(vehicle, statusConfig).construct()
            if statusBlock and not operationError:
                items.append(formatters.packBuildUpBlockData(statusBlock, padding=blockPadding, blockWidth=440))
            else:
                self._setContentMargin(bottom=bottomPadding)
        return items


class EventStatusBlockConstructor(StatusBlockConstructor):

    def construct(self):
        state = getVehicleState(self.vehicle)
        if state.value == VehicleStates.LOCKED.value:
            return (
             [
              formatters.packAlignedTextBlockData(text_styles.statusAlert(backport.text(R.strings.halloween_tooltips.vehicle.rentState())), BLOCKS_TOOLTIP_TYPES.ALIGN_CENTER)],
             None, None)
        else:
            if state.value == VehicleStates.INPLATOON.value:
                return (
                 [
                  formatters.packAlignedTextBlockData(text_styles.statusAttention(backport.text(R.strings.halloween_lobby.carousel.card.inPlatoon())), BLOCKS_TOOLTIP_TYPES.ALIGN_CENTER)],
                 None, None)
            if state.value == VehicleStates.INBATTLE.value:
                return (
                 [
                  formatters.packAlignedTextBlockData(text_styles.critical(backport.text(R.strings.halloween_lobby.carousel.card.inBattle())), BLOCKS_TOOLTIP_TYPES.ALIGN_CENTER)],
                 None, None)
            return super(EventStatusBlockConstructor, self).construct()


class EventHeaderBlockConstructor(HeaderBlockConstructor):

    def construct(self):
        block = []
        headerBlocks = []
        nameStr = text_styles.highTitle(self.vehicle.userName)
        icon = getTypeBigIconPath(self.vehicle.type, False)
        headerBlocks.append(formatters.packImageTextBlockData(title=nameStr, desc='', img=icon, imgPadding=formatters.packPadding(left=10, top=-15), txtGap=-9, txtOffset=99, padding=formatters.packPadding(top=15, bottom=-15 if self.vehicle.isFavorite else -21)))
        headerBlocks.append(formatters.packTextBlockData(text_styles.main(self.vehicle.fullDescription), padding=formatters.packPadding(top=-28, left=99, bottom=9)))
        block.append(formatters.packBuildUpBlockData(headerBlocks, stretchBg=False, linkage=BLOCKS_TOOLTIP_TYPES.TOOLTIP_BUILDUP_BLOCK_NORMAL_VEHICLE_BG_LINKAGE, padding=formatters.packPadding(left=-self.leftPadding)))
        return block