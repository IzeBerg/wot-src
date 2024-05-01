import random, BigWorld, Math, Keys, CommandMapping
from aih_constants import CTRL_MODE_NAME
from AvatarInputHandler.DynamicCameras import ArcadeCamera
from AvatarInputHandler.PostmortemDelay import PostmortemDelay
from AvatarInputHandler.MapCaseMode import _ArenaBoundsAreaStrikeSelector, MapCaseControlModeBase
from AvatarInputHandler.control_modes import ArcadeControlMode, PostMortemControlMode
from AvatarInputHandler import AimingSystems
from cosmic_camera import CosmicCamera
from cosmic_sound import CosmicBattleSounds
from gui.shared.events import DeathCamEvent
TOP_TERRAIN_HEIGHT = 65
BOT_Y = 0
MIN_Y_HEIGHT = 28.0

def rescanPosition(position):
    top = Math.Vector3(position.x, TOP_TERRAIN_HEIGHT, position.z)
    bot = Math.Vector3(position.x, BOT_Y, position.z)
    terrainPos = AimingSystems.__collideStaticOnly(top, bot)[0]
    terrainPos.y = max(MIN_Y_HEIGHT, terrainPos.y)
    return terrainPos


class _CosmicArenaBoundStrikeSelector(_ArenaBoundsAreaStrikeSelector):

    def __init__(self, *args, **kwargs):
        super(_CosmicArenaBoundStrikeSelector, self).__init__(*args, **kwargs)
        self.area.enableWaterCollision(True)
        self.area.setMaxHeight(TOP_TERRAIN_HEIGHT)

    def processSelection(self, position, reset=False):
        position = rescanPosition(position)
        return super(_CosmicArenaBoundStrikeSelector, self).processSelection(position, reset)


class CosmicVortexStrikeSelector(_CosmicArenaBoundStrikeSelector):

    def processSelection(self, position, reset=False):
        CosmicBattleSounds.Abilities.vortexActivated(reset)
        return super(CosmicVortexStrikeSelector, self).processSelection(position, reset)


class CosmicRepulsorStrikeSelector(_CosmicArenaBoundStrikeSelector):

    def processSelection(self, position, reset=False):
        CosmicBattleSounds.Abilities.repulsorActivated(reset)
        return super(CosmicRepulsorStrikeSelector, self).processSelection(position, reset)


class CosmicEventJumpStrikeSelector(_CosmicArenaBoundStrikeSelector):

    def processSelection(self, position, reset=False):
        CosmicBattleSounds.Abilities.jumpActivated(reset)
        return super(CosmicEventJumpStrikeSelector, self).processSelection(position, reset)


class CosmicControlMode(ArcadeControlMode):

    def _setupCamera(self, dataSection):
        self._cam = CosmicCamera(dataSection['camera'], defaultOffset=self._defaultOffset)


class CosmicArcadeMapCaseControlMode(MapCaseControlModeBase):
    MODE_NAME = CTRL_MODE_NAME.MAP_CASE_ARCADE

    def _createCamera(self, config, offset=Math.Vector2(0, 0)):
        return ArcadeCamera.ArcadeCamera(config, offset)

    def _initCamera(self):
        self.camera.create()

    def _getCameraDesiredShotPoint(self):
        return self.camera.aimingSystem.getDesiredShotPoint()

    def _getPreferedPositionOnQuit(self):
        return self.camera.aimingSystem.getThirdPersonShotPoint()

    def handleKeyEvent(self, isDown, key, mods, event=None):
        isDeactivateButtonPressed = key == Keys.KEY_ESCAPE or CommandMapping.g_instance.isFired(CommandMapping.CMD_AMMO_CHOICE_3, key)
        super(CosmicArcadeMapCaseControlMode, self).handleKeyEvent(isDown, key, mods, event)
        if isDeactivateButtonPressed and mods != Keys.MODIFIER_CTRL and isDown:
            CosmicBattleSounds.Abilities.vortexActivated(True)


class CosmicPostmortemDelay(PostmortemDelay):
    FADE_DELAY_TIME = 2.0
    KILLER_VISION_TIME = 5.0

    def _getKillerVisionVehicleID(self):
        player = BigWorld.player()
        killerID = player.inputHandler.getKillerVehicleID()
        playerVehicleID = player.playerVehicleID
        if not killerID or killerID == playerVehicleID:
            candidates = []
            for vehicle in BigWorld.entities.valuesOfType('Vehicle'):
                if vehicle.health > 0 and vehicle.id != playerVehicleID:
                    candidates.append(vehicle.id)

            if candidates:
                return random.choice(candidates)
        return killerID


class CosmicPostmortemControlMode(PostMortemControlMode):
    _POSTMORTEM_DELAY_IMPL = CosmicPostmortemDelay

    @property
    def killCamState(self):
        return DeathCamEvent.State.ACTIVE