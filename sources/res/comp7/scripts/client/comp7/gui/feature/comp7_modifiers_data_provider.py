from battle_modifiers.gui.feature.modifiers_data_provider import ModifiersDataProvider
from comp7.constants import COMP7_SEASON_MODIFIERS_DOMAIN

class Comp7ModifiersDataProvider(ModifiersDataProvider):

    def _readClientDomain(self, modifier):
        return COMP7_SEASON_MODIFIERS_DOMAIN