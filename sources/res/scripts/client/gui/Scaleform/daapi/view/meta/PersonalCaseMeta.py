from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class PersonalCaseMeta(AbstractWindowView):

    def dismissTankman(self, inventoryID):
        self._printOverrideError('dismissTankman')

    def unloadTankman(self, inventoryid, currentVehicleID):
        self._printOverrideError('unloadTankman')

    def getCommonData(self):
        self._printOverrideError('getCommonData')

    def getDossierData(self):
        self._printOverrideError('getDossierData')

    def getRetrainingData(self):
        self._printOverrideError('getRetrainingData')

    def retrainingTankman(self, inventoryID, tankmanCostTypeIndex):
        self._printOverrideError('retrainingTankman')

    def getFreeSkillsData(self):
        self._printOverrideError('getFreeSkillsData')

    def getSkillsData(self):
        self._printOverrideError('getSkillsData')

    def getDocumentsData(self):
        self._printOverrideError('getDocumentsData')

    def addTankmanSkill(self, inventoryID, skillName):
        self._printOverrideError('addTankmanSkill')

    def addTankmanFreeSkill(self, inventoryID, skillName):
        self._printOverrideError('addTankmanFreeSkill')

    def dropSkills(self):
        self._printOverrideError('dropSkills')

    def showFreeSkillsInfo(self):
        self._printOverrideError('showFreeSkillsInfo')

    def changeTankmanPassport(self, inventoryID, firstNameID, firstNameGroup, lastNameID, lastNameGroup, iconID, iconGroup):
        self._printOverrideError('changeTankmanPassport')

    def changeRetrainVehicle(self, intCD):
        self._printOverrideError('changeRetrainVehicle')

    def openExchangeFreeToTankmanXpWindow(self):
        self._printOverrideError('openExchangeFreeToTankmanXpWindow')

    def openChangeRoleWindow(self):
        self._printOverrideError('openChangeRoleWindow')

    def getCrewSkinsData(self):
        self._printOverrideError('getCrewSkinsData')

    def equipCrewSkin(self, crewSkinID):
        self._printOverrideError('equipCrewSkin')

    def unequipCrewSkin(self):
        self._printOverrideError('unequipCrewSkin')

    def takeOffNewMarkFromCrewSkin(self, crewSkinID):
        self._printOverrideError('takeOffNewMarkFromCrewSkin')

    def changeHistoricallyAccurate(self, historicallyAccurate):
        self._printOverrideError('changeHistoricallyAccurate')

    def playCrewSkinSound(self, crewSkinID):
        self._printOverrideError('playCrewSkinSound')

    def updateOpenedTabID(self, tabID):
        self._printOverrideError('updateOpenedTabID')

    def as_setCommonDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setCommonData(data)

    def as_setDossierDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setDossierData(data)

    def as_setRetrainingDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setRetrainingData(data)

    def as_setFreeSkillsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setFreeSkillsData(data)

    def as_setSkillsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setSkillsData(data)

    def as_setCrewSkinsNewCountS(self, count):
        if self._isDAAPIInited():
            return self.flashObject.as_setCrewSkinsNewCount(count)

    def as_setDocumentsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setDocumentsData(data)

    def as_setDocumentsIsChangeEnableS(self, changeDocumentsEnable, warning):
        if self._isDAAPIInited():
            return self.flashObject.as_setDocumentsIsChangeEnable(changeDocumentsEnable, warning)

    def as_setCrewSkinsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setCrewSkinsData(data)

    def as_openTabS(self, tabID):
        if self._isDAAPIInited():
            return self.flashObject.as_openTab(tabID)