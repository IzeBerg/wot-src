from gui.impl.lobby.tabs_controller import tabUpdateFunc
from gui.impl.lobby.tank_setup.array_providers.frontline import BattleAbilityProvider
from gui.impl.lobby.tank_setup.configurations.base import BaseTankSetupTabsController, BaseDealPanel

class FrontlineTabs(object):
    BATTLE_ABILITY = 'battleAbility'
    ALL = (
     BATTLE_ABILITY,)


class FrontlineTabsController(BaseTankSetupTabsController):
    __slots__ = ()

    def getDefaultTab(self):
        return FrontlineTabs.BATTLE_ABILITY

    @tabUpdateFunc(FrontlineTabs.BATTLE_ABILITY)
    def _updateOptDevice(self, viewModel, isFirst=False):
        pass

    def tabOrderKey(self, tabName):
        return FrontlineTabs.ALL.index(tabName)

    def _getAllProviders(self):
        return {FrontlineTabs.BATTLE_ABILITY: BattleAbilityProvider}


class FrontlineDealPanel(BaseDealPanel):

    @classmethod
    def updateDealPanelPrice(cls, items, dealPanelModel):
        pass