from HeroTank import HeroTank

class HBMainHeroTank(HeroTank):

    def removeModelFromScene(self):
        if self.isVehicleLoaded:
            self._onVehicleDestroy()

    def _onVehicleDestroy(self):
        super(HBMainHeroTank, self)._onVehicleDestroy()
        self.removeVehicle()