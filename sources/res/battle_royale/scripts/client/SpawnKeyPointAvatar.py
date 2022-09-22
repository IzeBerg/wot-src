import BigWorld
from shared_utils import nextTick
from AvatarInputHandler.control_modes import ArcadeControlMode

class SpawnKeyPointAvatar(BigWorld.DynamicScriptComponent):

    def receiveAvailableSpawnKeyPoints(self, points):
        spawnCtrl = self.entity.guiSessionProvider.dynamic.spawn
        if spawnCtrl:
            spawnCtrl.showSpawnPoints(points)

    def receiveTeamSpawnKeyPoints(self, pointsByVehicle):
        spawnCtrl = self.entity.guiSessionProvider.dynamic.spawn
        if spawnCtrl:
            spawnCtrl.updateTeamSpawnKeyPoints(pointsByVehicle)

    def receiveSpawnKeyPointsCloseTime(self, serverTime):
        spawnCtrl = self.entity.guiSessionProvider.dynamic.spawn
        if spawnCtrl:
            spawnCtrl.setupCloseTime(serverTime)

    def closeChooseSpawnKeyPointsWindow(self):
        spawnCtrl = self.entity.guiSessionProvider.dynamic.spawn
        if spawnCtrl:
            spawnCtrl.closeSpawnPoints()
        if self.entity.getVehicleAttached() is not None:
            controlMode = self.entity.inputHandler.ctrl
            if isinstance(controlMode, ArcadeControlMode):
                camera = self.entity.inputHandler.ctrl.camera
                nextTick(camera.setToVehicleDirection)()
        return