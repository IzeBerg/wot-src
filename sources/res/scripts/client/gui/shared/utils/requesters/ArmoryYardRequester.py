import BigWorld
from adisp import adisp_async
from armory_yard_constants import PROGRESSION_LEVEL_PDATA_KEY, PDATA_KEY_ARMORY_YARD
from gui.shared.utils.requesters.abstract import AbstractSyncDataRequester
from skeletons.gui.shared.utils.requesters import IArmoryYardRequester

class ArmoryYardRequester(AbstractSyncDataRequester, IArmoryYardRequester):

    @property
    def data(self):
        return self._data

    @property
    def progressionLevel(self):
        return self._data.get(PROGRESSION_LEVEL_PDATA_KEY, 0)

    @adisp_async
    def _requestCache(self, callback):
        BigWorld.player().armoryYard.getCache(lambda resID, value: self._response(resID, value, callback))

    def _preprocessValidData(self, data):
        if PDATA_KEY_ARMORY_YARD in data:
            return dict(data[PDATA_KEY_ARMORY_YARD])
        return dict()