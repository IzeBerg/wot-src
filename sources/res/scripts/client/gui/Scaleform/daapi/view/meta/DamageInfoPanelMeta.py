from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class DamageInfoPanelMeta(BaseDAAPIComponent):

    def as_showS(self, itemList, showFire):
        if self._isDAAPIInited():
            return self.flashObject.as_show(itemList, showFire)

    def as_hideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide()

    def as_updateEngineS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateEngine(stateId, isHit)

    def as_hideEngineS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideEngine()

    def as_updateAmmoBayS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateAmmoBay(stateId, isHit)

    def as_hideAmmoBayS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideAmmoBay()

    def as_updateFuelTankS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateFuelTank(stateId, isHit)

    def as_hideFuelTankS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideFuelTank()

    def as_updateRadioS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateRadio(stateId, isHit)

    def as_hideRadioS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideRadio()

    def as_updateLeftTrackS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLeftTrack(stateId, isHit)

    def as_hideLeftTrackS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideLeftTrack()

    def as_updateRightTrackS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateRightTrack(stateId, isHit)

    def as_hideRightTrackS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideRightTrack()

    def as_updateGunS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateGun(stateId, isHit)

    def as_hideGunS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideGun()

    def as_updateTurretRotatorS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTurretRotator(stateId, isHit)

    def as_hideTurretRotatorS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideTurretRotator()

    def as_updateSurveyingDeviceS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSurveyingDevice(stateId, isHit)

    def as_hideSurveyingDeviceS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideSurveyingDevice()

    def as_updateWheelS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateWheel(stateId, isHit)

    def as_hideWheelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideWheel()

    def as_updateCommanderS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateCommander(stateId, isHit)

    def as_hideCommanderS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideCommander()

    def as_updateFirstGunnerS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateFirstGunner(stateId, isHit)

    def as_updateSecondGunnerS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSecondGunner(stateId, isHit)

    def as_hideFirstGunnerS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideFirstGunner()

    def as_hideSecondGunnerS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideSecondGunner()

    def as_updateDriverS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateDriver(stateId, isHit)

    def as_hideDriverS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideDriver()

    def as_updateFirstRadiomanS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateFirstRadioman(stateId, isHit)

    def as_updateSecondRadiomanS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSecondRadioman(stateId, isHit)

    def as_hideFirstRadiomanS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideFirstRadioman()

    def as_hideSecondRadiomanS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideSecondRadioman()

    def as_updateFirstLoaderS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateFirstLoader(stateId, isHit)

    def as_updateSecondLoaderS(self, stateId, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSecondLoader(stateId, isHit)

    def as_hideFirstLoaderS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideFirstLoader()

    def as_hideSecondLoaderS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideSecondLoader()

    def as_showFireS(self, isHit):
        if self._isDAAPIInited():
            return self.flashObject.as_showFire(isHit)

    def as_hideFireS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideFire()