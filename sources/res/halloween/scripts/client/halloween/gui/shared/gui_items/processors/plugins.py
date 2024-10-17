from gui.shared.gui_items.processors.plugins import SyncValidator, makeError, makeSuccess

class CheckArtefact(SyncValidator):

    def __init__(self, controller, artefactID, isSkipQuest, isEnabled=True):
        super(CheckArtefact, self).__init__(isEnabled)
        self.controller = controller
        self.artefactID = artefactID
        self.isSkipQuest = isSkipQuest

    def _validate(self):
        controller = self.controller
        if not controller.isEnabled():
            return makeError('server_error')
        else:
            artefact = controller.getArtefact(self.artefactID)
            if not self.isSkipQuest:
                if not controller.isArtefactReceived(self.artefactID):
                    return makeError('server_error')
                decodePrice = artefact.decodePrice
                if decodePrice.currency is None or decodePrice.amount > controller.getArtefactKeyQuantity():
                    return makeError('server_error')
            else:
                skipPrice = artefact.skipPrice
                if skipPrice.currency is None or skipPrice.amount > controller.getArtefactKeyQuantity():
                    return makeError('server_error')
            return makeSuccess()