from cgf_script.managers_registrator import Rule, registerManager
from points_of_interest.managers import PoiStateManager, PoiViewStateManager, PoiSoundManager

class PointsOfInterestRule(Rule):
    category = 'Points Of Interest'

    @registerManager(PoiStateManager)
    def registerPoiStateManager(self):
        return

    @registerManager(PoiViewStateManager)
    def registerPoiViewStateManager(self):
        return

    @registerManager(PoiSoundManager)
    def registerPoiSoundManager(self):
        return