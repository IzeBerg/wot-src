from gui.Scaleform.daapi.view.lobby.vehicle_compare.cmp_configurator_base import VehicleCompareConfiguratorBaseView

class VehicleCompareConfiguratorViewMeta(VehicleCompareConfiguratorBaseView):

    def removeDevice(self, slotType, slotIndex):
        self._printOverrideError('removeDevice')

    def selectShell(self, shellId, slotIndex):
        self._printOverrideError('selectShell')

    def camoSelected(self, selected):
        self._printOverrideError('camoSelected')

    def showModules(self):
        self._printOverrideError('showModules')

    def toggleTopModules(self, value):
        self._printOverrideError('toggleTopModules')

    def skillSelect(self, skillType, slotIndex, selected):
        self._printOverrideError('skillSelect')

    def changeCrewLevel(self, crewLevelId):
        self._printOverrideError('changeCrewLevel')

    def as_setDevicesDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setDevicesData(data)

    def as_setAmmoS(self, shells):
        if self._isDAAPIInited():
            return self.flashObject.as_setAmmo(shells)

    def as_setSelectedAmmoIndexS(self, index):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelectedAmmoIndex(index)

    def as_setCamoS(self, selected):
        if self._isDAAPIInited():
            return self.flashObject.as_setCamo(selected)

    def as_disableCamoS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_disableCamo()

    def as_setSkillsBlockedS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSkillsBlocked(value)

    def as_setCrewAttentionIconVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setCrewAttentionIconVisible(value)

    def as_setSkillsS(self, skills):
        if self._isDAAPIInited():
            return self.flashObject.as_setSkills(skills)

    def as_setTopModulesSelectedS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setTopModulesSelected(value)

    def as_setCrewLevelIndexS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setCrewLevelIndex(value)