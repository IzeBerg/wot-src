import BigWorld

class GunMarkerComponent(BigWorld.DynamicScriptComponent):

    def set_gunMarker(self, _=None):
        gunMarker = self.gunMarker
        if gunMarker is None:
            return
        else:
            avatar = BigWorld.player()
            avatar.updateGunMarker(self.entity.id, gunMarker.gunPosition, gunMarker.shotVector, gunMarker.dispersion)
            return