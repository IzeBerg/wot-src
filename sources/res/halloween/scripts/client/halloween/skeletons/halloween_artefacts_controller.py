from skeletons.gui.game_control import IGameController

class IHalloweenArtefactsController(IGameController):
    onArtefactStatusUpdated = None
    onArtefactKeyUpdated = None
    onArtefactSettingsUpdated = None

    def isEnabled(self):
        raise NotImplementedError

    def artefactsSorted(self):
        raise NotImplementedError

    def regularArtefacts(self):
        raise NotImplementedError

    def getFinalArtefact(self):
        raise NotImplementedError

    def getArtefact(self, artefactID):
        raise NotImplementedError

    def isArtefactOpened(self, artefactID):
        raise NotImplementedError

    def isArtefactReceived(self, artefactID):
        raise NotImplementedError

    def getArtefactKeyQuantity(self):
        raise NotImplementedError

    def getCurrentArtefactProgress(self):
        raise NotImplementedError

    def getAvailableArtefactProgress(self):
        raise NotImplementedError

    def getMaxArtefactsProgress(self):
        raise NotImplementedError

    def getArtefactIDForAccessToVehicle(self, vehTypeCD):
        raise NotImplementedError

    def openArtefact(self, artefactID, isSkipQuest):
        raise NotImplementedError

    def getMainGiftVehicle(self):
        raise NotImplementedError

    def getMainGiftStyle(self):
        raise NotImplementedError

    def geArtefactIDFromOpenToken(self, token):
        raise NotImplementedError

    def isFinalArtefact(self, artefect):
        raise NotImplementedError

    def getIndex(self, artefactID):
        raise NotImplementedError

    def getPhaseCompletionArtefact(self, phase, difficulty):
        raise NotImplementedError