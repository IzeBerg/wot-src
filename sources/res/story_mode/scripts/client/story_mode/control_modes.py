import math, BigWorld, CommandMapping
from AvatarInputHandler.DynamicCameras.ArcadeCamera import ArcadeCamera
from AvatarInputHandler.control_modes import ArcadeControlMode, SniperControlMode
from Vehicle import Vehicle
from constants import AIMING_MODE, VEHICLE_BUNKER_TURRET_TAG
from helpers import dependency
from story_mode.gui.app_loader import observers
from story_mode.skeletons.story_mode_controller import IStoryModeController

def targetIsBunker():
    target = BigWorld.target()
    if not isinstance(target, Vehicle):
        return False
    return VEHICLE_BUNKER_TURRET_TAG in target.typeDescriptor.type.tags


class StoryModeArcadeCamera(ArcadeCamera):
    _START_DISTANCE = 10
    _START_ANGLE = 80

    def create(self, onChangeControlMode=None, postmortemMode=False, smartPointCalculator=True):
        prevStartDist = self._cfg['startDist']
        prevStartAngle = self._cfg['startAngle']
        self._cfg['startDist'] = self._START_DISTANCE
        self._cfg['startAngle'] = math.radians(self._START_ANGLE) - math.pi * 0.5
        super(StoryModeArcadeCamera, self).create(onChangeControlMode, postmortemMode, smartPointCalculator)
        self._cfg['startDist'] = prevStartDist
        self._cfg['startAngle'] = prevStartAngle


class StoryModeArcadeControlModeStartCamera(ArcadeControlMode):

    def _setupCamera(self, dataSection):
        self._cam = StoryModeArcadeCamera(dataSection['camera'], defaultOffset=self._defaultOffset)


class OnboardingArcadeControlMode(StoryModeArcadeControlModeStartCamera):
    _storyModeCtrl = dependency.descriptor(IStoryModeController)

    @property
    def isWinMessageShown(self):
        battlePage = observers.getStoryModeBattle()
        return battlePage is not None and battlePage.isWinMessageShown

    def handleKeyEvent(self, isDown, key, mods, event=None):
        cmdMap = CommandMapping.g_instance
        if cmdMap.isFired(CommandMapping.CMD_CM_LOCK_TARGET, key) and self._storyModeCtrl.isOnboarding:
            isFiredFreeCamera = cmdMap.isFired(CommandMapping.CMD_CM_FREE_CAMERA, key)
            if isFiredFreeCamera:
                self.setAimingMode(isDown, AIMING_MODE.USER_DISABLED)
            return False
        if cmdMap.isFired(CommandMapping.CMD_CM_ALTERNATE_MODE, key) and self.isWinMessageShown:
            return False
        return super(OnboardingArcadeControlMode, self).handleKeyEvent(isDown, key, mods, event)

    def onChangeControlModeByScroll(self):
        if self.isWinMessageShown:
            return
        super(OnboardingArcadeControlMode, self).onChangeControlModeByScroll()


class OnboardingSniperControlMode(SniperControlMode):
    _storyModeCtrl = dependency.descriptor(IStoryModeController)

    def handleKeyEvent(self, isDown, key, mods, event=None):
        if CommandMapping.g_instance.isFired(CommandMapping.CMD_CM_LOCK_TARGET, key) and self._storyModeCtrl.isOnboarding:
            return False
        return super(OnboardingSniperControlMode, self).handleKeyEvent(isDown, key, mods, event)


class StoryModeArcadeControlMode(StoryModeArcadeControlModeStartCamera):

    def handleKeyEvent(self, isDown, key, mods, event=None):
        if CommandMapping.g_instance.isFired(CommandMapping.CMD_CM_LOCK_TARGET, key) and targetIsBunker():
            return False
        return super(StoryModeArcadeControlMode, self).handleKeyEvent(isDown, key, mods, event)


class StoryModeSniperControlMode(SniperControlMode):

    def handleKeyEvent(self, isDown, key, mods, event=None):
        if CommandMapping.g_instance.isFired(CommandMapping.CMD_CM_LOCK_TARGET, key) and targetIsBunker():
            return False
        return super(StoryModeSniperControlMode, self).handleKeyEvent(isDown, key, mods, event)