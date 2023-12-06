import CGF
from cgf_script.managers_registrator import registerRule, registerManager, Rule
from new_year.cgf_components.lobby_customization_components import LobbyCustomizableObjectsManager

@registerRule
class NyHangarRule(Rule):
    category = 'New year rules'
    domain = CGF.DomainOption.DomainClient

    @registerManager(LobbyCustomizableObjectsManager)
    def reg1(self):
        return