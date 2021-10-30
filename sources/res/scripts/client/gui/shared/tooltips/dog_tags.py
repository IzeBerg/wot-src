import BigWorld
from dog_tags_common.components_config import componentConfigAdapter as cca
from dog_tags_common.config.common import ComponentViewType
from dog_tags_common.number_formatter import formatComponentValue
from dog_tags_common.player_dog_tag import PlayerDogTag
from gui.dog_tag_composer import dogTagComposer, AssetSize
from gui.impl import backport
from gui.impl.gen import R
from gui.shared.formatters import text_styles
from gui.shared.tooltips import formatters
from gui.shared.tooltips.common import BlocksTooltipData
from helpers import getLanguageCode, dependency
from skeletons.gui.shared import IItemsCache

class DogTagInfoTooltip(BlocksTooltipData):
    itemsCache = dependency.descriptor(IItemsCache)
    __titlePadding = formatters.packPadding(top=2)
    __levelPadding = formatters.packPadding(top=-3, bottom=-5)
    __imagePaddingTop = 13
    __imagePaddingBottom = 5
    __imageNegativeHeight = -120
    __descriptionPadding = formatters.packPadding(bottom=-10)

    def __init__(self, context):
        super(DogTagInfoTooltip, self).__init__(context, None)
        self._setWidth(200)
        return

    def _packBlocks(self, compId, userID=None):
        items = super(DogTagInfoTooltip, self)._packBlocks()
        comp = cca.getComponentById(compId)
        if userID is None:
            componentProgress = BigWorld.player().dogTags.getComponentProgress(compId)
        else:
            dogTag = PlayerDogTag.fromDict(self.itemsCache.items.getDogTag(int(userID)))
            componentProgress = dogTag.getComponentByType(comp.viewType)
        items.append(formatters.packTextBlockData(text_styles.middleTitle(dogTagComposer.getComponentTitle(compId)), padding=self.__titlePadding))
        typeLevelBlock = [
         text_styles.main(dogTagComposer.getComponentType(compId))]
        valueBlock = list()
        if comp.viewType == ComponentViewType.ENGRAVING:
            typeLevelBlock.append(text_styles.main(', '))
            typeLevelBlock.append(text_styles.neutral(('{} {}').format(backport.text(R.strings.dogtags.customization.tooltip.level()), componentProgress.grade + 1)))
            valueBlock.append(text_styles.main(('{}: ').format(backport.text(R.strings.dogtags.customization.tooltip.value()))))
            statValue = componentProgress.value
            statStr = formatComponentValue(getLanguageCode(), statValue, comp.numberType, specialReplacements=False)
            valueBlock.append(text_styles.neutral(statStr))
        items.append(formatters.packTextBlockData(text_styles.concatStylesToSingleLine(*typeLevelBlock), padding=self.__levelPadding))
        items.append(formatters.packTextBlockData(text_styles.concatStylesToSingleLine(*valueBlock)))
        if comp.viewType == ComponentViewType.BACKGROUND:
            items.append(formatters.packImageBlockData(dogTagComposer.getComponentImageFullPath(AssetSize.SMALL, compId), padding=formatters.packPadding(top=self.__imagePaddingTop, bottom=self.__imagePaddingBottom)))
        else:
            images = [
             formatters.packImageBlockData(dogTagComposer.getDefaultBackgroundImageFullPath(AssetSize.SMALL), padding=formatters.packPadding(top=self.__imagePaddingTop)),
             formatters.packImageBlockData(dogTagComposer.getComponentImageFullPath(AssetSize.SMALL, compId, componentProgress.grade), padding=formatters.packPadding(top=self.__imageNegativeHeight, bottom=self.__imagePaddingBottom))]
            items.append(formatters.packBuildUpBlockData(blocks=images))
        items.append(formatters.packTextBlockData(text=text_styles.main(dogTagComposer.getComponentDescription(compId)), padding=self.__descriptionPadding))
        return [
         formatters.packBuildUpBlockData(blocks=items)]