import CGF
from cgf_script.managers_registrator import Rule, registerManager, registerRule
from points_of_interest.managers import PoiStateManager, PoiViewStateManager, PoiSoundManager

@registerRule
class PointsOfInterestRule(Rule):
    category = 'Points Of Interest'
    domain = CGF.DomainOption.DomainAll

    @registerManager(PoiStateManager)
    def registerPoiStateManager(self):
        return

    @registerManager(PoiViewStateManager)
    def registerPoiViewStateManager(self):
        return

    @registerManager(PoiSoundManager)
    def registerPoiSoundManager(self):
        return