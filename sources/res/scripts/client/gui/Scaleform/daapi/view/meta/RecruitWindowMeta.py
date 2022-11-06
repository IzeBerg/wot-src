from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class RecruitWindowMeta(AbstractWindowView):

    def updateVehicleClassDropdown(self, nation):
        self._printOverrideError('updateVehicleClassDropdown')

    def updateVehicleTypeDropdown(self, nation, vclass):
        self._printOverrideError('updateVehicleTypeDropdown')

    def updateRoleDropdown(self, nation, vclass, vtype):
        self._printOverrideError('updateRoleDropdown')

    def updateNationDropdown(self):
        self._printOverrideError('updateNationDropdown')

    def buyTankman(self, nationID, typeID, role, studyType, slot):
        self._printOverrideError('buyTankman')

    def updateAllDropdowns(self, nationID, tankType, typeID, roleType):
        self._printOverrideError('updateAllDropdowns')

    def as_setVehicleClassDropdownS(self, vehicleClassData):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehicleClassDropdown(vehicleClassData)

    def as_setVehicleTypeDropdownS(self, vehicleTypeData):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehicleTypeDropdown(vehicleTypeData)

    def as_setRoleDropdownS(self, roleData):
        if self._isDAAPIInited():
            return self.flashObject.as_setRoleDropdown(roleData)

    def as_initDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_initData(data)

    def as_setNationsS(self, nationsData):
        if self._isDAAPIInited():
            return self.flashObject.as_setNations(nationsData)

    def as_setRecruitButtonsEnableStateS(self, academyButtonEnabled, schoolButtonEnabled, coursesButtonEnabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setRecruitButtonsEnableState(academyButtonEnabled, schoolButtonEnabled, coursesButtonEnabled)

    def as_setAllDropdownsS(self, nationsData, vehicleClassData, vehicleTypeData, roleData):
        if self._isDAAPIInited():
            return self.flashObject.as_setAllDropdowns(nationsData, vehicleClassData, vehicleTypeData, roleData)