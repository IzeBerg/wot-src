import logging, typing
from account_helpers.settings_core.ServerSettingsManager import UI_STORAGE_KEYS
import wg_async
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.tank_setup.tank_setup_constants import TankSetupConstants
from gui.impl.lobby.tank_setup.tank_setup_sounds import playEnterTankSetupView, playExitTankSetupView
from gui.impl.lobby.common.info_view import InfoView, getInfoWindowProc, createContentData
from gui.limited_ui.lui_rules_storage import LuiRules
from helpers import dependency
from skeletons.gui.impl import IGuiLoader
if typing.TYPE_CHECKING:
    from gui.impl.lobby.common.info_view import IInfoWindowProcessor
_logger = logging.getLogger(__name__)

class _IntroAmmunitionSetupView(InfoView):
    _guiLoader = dependency.descriptor(IGuiLoader)
    __slots__ = ('__hasTankSetupView', )

    def __init__(self, *args, **kwargs):
        super(_IntroAmmunitionSetupView, self).__init__(*args, **kwargs)
        self.__hasTankSetupView = self._guiLoader.windowsManager.getViewByLayoutID(R.views.lobby.tanksetup.HangarAmmunitionSetup())

    def _initialize(self, *args, **kwargs):
        super(_IntroAmmunitionSetupView, self)._initialize()
        if not self.__hasTankSetupView:
            playEnterTankSetupView()

    def _finalize(self):
        if not self.__hasTankSetupView:
            playExitTankSetupView()
        super(_IntroAmmunitionSetupView, self)._finalize()


@wg_async.wg_async
def showIntro(introKey, *args, **kwargs):
    tankSetupToIntroWindowProc = {TankSetupConstants.OPT_DEVICES: getIntroAmmunitionSetupWindowProc, 
       TankSetupConstants.BATTLE_ABILITIES: getIntroBattleAbilitiesSetupWindowProc}
    if introKey in tankSetupToIntroWindowProc:
        yield tankSetupToIntroWindowProc[introKey]().show(*args, **kwargs)


def getIntroAmmunitionSetupWindowProc():
    return getInfoWindowProc(R.views.lobby.tanksetup.IntroScreen(), createContentData(_IntroAmmunitionSetupView), UI_STORAGE_KEYS.OPTIONAL_DEVICE_SETUP_INTRO_SHOWN, LuiRules.AP_ZONE_HINT)


def getIntroBattleAbilitiesSetupWindowProc():
    return getInfoWindowProc(R.views.lobby.frontline.IntroScreen(), createContentData(_IntroAmmunitionSetupView), UI_STORAGE_KEYS.EPIC_BATTLE_ABILITIES_INTRO_SHOWN, LuiRules.AP_BATTLE_ABILITIES_HINT)