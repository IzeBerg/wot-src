import BigWorld, BattleReplay
from bootcamp.Bootcamp import g_bootcamp
from bootcamp.hints.HintCustom import HintCustom
from bootcamp.hints.HintsSystem import HintSystem
from bootcamp.BootcampMarkers import BootcampMarkersManager
from bootcamp.BootcampContext import Chapter

class HintManager(object):

    def __init__(self):
        self._hintSystem = HintSystem(BigWorld.player())
        self._updateId = None
        self._hints = {}
        self._markersActive = []
        chapter = Chapter('scripts/bootcamp_docs/entities.xml')
        avatar = BigWorld.player()
        markers = []
        if hasattr(avatar, 'arenaExtraData'):
            if 'markers' in avatar.arenaExtraData:
                markers = avatar.arenaExtraData['markers']
        self._markerManager = BootcampMarkersManager()
        self._markerManager.init(chapter, markers, g_bootcamp.getGUI())
        return

    @property
    def hintSystem(self):
        return self._hintSystem

    @property
    def markerManager(self):
        return self._markerManager

    @staticmethod
    def hintManager():
        return BigWorld.player().hintManager

    def _updateHintSystem(self):
        self._hintSystem.update()
        self._markerManager.update()
        self._updateId = BigWorld.callback(0.2, self._updateHintSystem)

    def start(self):
        self._hintSystem.start()
        self._markerManager.start()
        self._markerManager.afterScenery()
        self._updateHintSystem()

    def stop(self):
        if self._hintSystem is not None:
            self._hintSystem.stop()
            if self._updateId is not None:
                BigWorld.cancelCallback(self._updateId)
                self._updateId = None
            self._hintSystem = None
        if self._markerManager is not None:
            for markerName in self._markersActive:
                self._markerManager.hideMarker(markerName)

            self._markersActive = []
            self._markerManager.stop()
            self._markerManager.clear()
            self._markerManager = None
        return

    def getHint(self, hintId):
        return self._hints.get(hintId)

    def getHints(self):
        return self._hints

    def addHint(self, hintParams, secondary=False):
        hint = HintCustom(*hintParams)
        self._hintSystem.addHint(hint)
        self._hints[hint.id] = hint
        return hint

    def addMarker(self, marker):
        markerParams = {'name': marker.name, 'style': marker.style, 'position': marker.position}
        self._markerManager.addMarker(markerParams)

    def showMarker(self, marker):
        if not BattleReplay.g_replayCtrl.isPlaying:
            if marker.name not in self._markersActive:
                self._markersActive.append(marker.name)
                self._markerManager.showMarker(marker.name)

    def hideMarker(self, marker):
        if not BattleReplay.g_replayCtrl.isPlaying:
            if marker.name in self._markersActive:
                self._markerManager.hideMarker(marker.name)
                self._markersActive.remove(marker.name)

    def isMarkerVisible(self, marker):
        if not BattleReplay.g_replayCtrl.isPlaying:
            return marker.name in self._markersActive