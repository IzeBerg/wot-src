from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.lobby.tank_setup.ammunition_setup.hangar import HangarAmmunitionSetupView
from gui.impl.lobby.tank_setup.frontline.ammunition_setup import FrontlineAmmunitionSetupView
from helpers import dependency
from skeletons.gui.game_control import IEpicBattleMetaGameController

class AmmunitionSetupViewAdaptor(InjectComponentAdaptor):
    __epicController = dependency.descriptor(IEpicBattleMetaGameController)

    def __init__(self, ctx):
        super(AmmunitionSetupViewAdaptor, self).__init__()
        self.__ctx = ctx

    def _makeInjectView(self):
        if self.__epicController.isEpicPrbActive():
            injectView = FrontlineAmmunitionSetupView(**self.__ctx)
        else:
            injectView = HangarAmmunitionSetupView(**self.__ctx)
        self.__ctx = None
        return injectView