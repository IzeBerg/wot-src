from gui.Scaleform.genConsts.STORE_CONSTANTS import STORE_CONSTANTS
from gui.Scaleform.locale.RES_SHOP import RES_SHOP
from gui.game_control.event_progression_controller import EventProgressionScreens
from gui.impl import backport
from gui.impl.gen import R
from helpers import dependency
from skeletons.gui.game_control import IEventProgressionController
from skeletons.gui.shared.congrats import ICongratsCtx

class CongratsCtx(ICongratsCtx):

    @property
    def background(self):
        return R.images.gui.maps.icons.store.shop_2_background_arsenal()

    @property
    def title(self):
        return R.strings.store.congratulationAnim.buyingLabel()

    @property
    def description(self):
        return ''

    @property
    def image(self):
        return self.imageAlt

    @property
    def imageAlt(self):
        return RES_SHOP.getVehicleIcon(STORE_CONSTANTS.ICON_SIZE_LARGE, 'empty_tank')

    @property
    def confirmLabel(self):
        return R.strings.store.congratulationAnim.confirmLabel()

    @property
    def backLabel(self):
        return R.invalid()

    def onConfirm(self):
        pass

    def onBack(self):
        pass


class GUIItemCongratsCtx(CongratsCtx):

    def __init__(self, item):
        self._item = item


class StyleCongratsCtx(GUIItemCongratsCtx):

    @property
    def description(self):
        return backport.text(R.strings.store.congratulationAnim.descriptionLabel.style(), name=self._item.userName)

    @property
    def image(self):
        size = STORE_CONSTANTS.ICON_SIZE_LARGE
        if RES_SHOP.hasStyleIcon(size, self._item.id):
            return RES_SHOP.getStyleIcon(size, self._item.id)
        return self._item.icon


class EventProgressionCongratsCtx(CongratsCtx):
    __eventProgression = dependency.descriptor(IEventProgressionController)

    @property
    def background(self):
        return R.images.gui.maps.icons.epicBattles.backgrounds.back_congrats()

    def onConfirm(self):
        self.__eventProgression.showCustomScreen(EventProgressionScreens.MAIN)


class EventProgressionStyleCongratsCtx(EventProgressionCongratsCtx, StyleCongratsCtx):
    pass