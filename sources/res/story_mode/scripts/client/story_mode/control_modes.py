import BigWorld, CommandMapping
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


class OnboardingArcadeControlMode(ArcadeControlMode):
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


class StoryModeArcadeControlMode(ArcadeControlMode):

    def handleKeyEvent(self, isDown, key, mods, event=None):
        if CommandMapping.g_instance.isFired(CommandMapping.CMD_CM_LOCK_TARGET, key) and targetIsBunker():
            return False
        return super(StoryModeArcadeControlMode, self).handleKeyEvent(isDown, key, mods, event)


class StoryModeSniperControlMode(SniperControlMode):

    def handleKeyEvent(self, isDown, key, mods, event=None):
        if CommandMapping.g_instance.isFired(CommandMapping.CMD_CM_LOCK_TARGET, key) and targetIsBunker():
            return False
        return super(StoryModeSniperControlMode, self).handleKeyEvent(isDown, key, mods, event)