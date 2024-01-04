from frameworks.wulf import ViewModel

class LootRendererTypes(ViewModel):
    __slots__ = ()
    DEF = 'LootDefRenderer'
    VIDEO = 'LootVideoRenderer'
    VEHICLE = 'LootVehicleRenderer'
    VEHICLE_VIDEO = 'LootVehicleVideoRenderer'
    ANIMATED = 'LootAnimatedRenderer'
    CONVERSION = 'LootConversionRenderer'
    COMPENSATION = 'LootCompensationRenderer'
    CREWSKINS_COMPENSATION = 'CrewSkinsCompensationRenderer'
    VEHICLE_COMPENSATION = 'VehicleCompensationRenderer'
    VEHICLE_COMPENSATION_WITHOUT_ANIMATION = 'VehicleCompensationWithoutAnimationRenderer'
    BLUEPRINT_FINAL_FRAGMENT = 'BlueprintFinalFragmentRenderer'
    CREW_BOOK = 'CrewBookRenderer'

    def __init__(self, properties=0, commands=0):
        super(LootRendererTypes, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(LootRendererTypes, self)._initialize()