from cgf_script.managers_registrator import registerManager, Rule
from new_year.cgf_components.other_entity_manager import OtherEntityManager

class OtherEntityCreatorRule(Rule):
    category = 'Hangar rules'

    @registerManager(OtherEntityManager)
    def reg1(self):
        return