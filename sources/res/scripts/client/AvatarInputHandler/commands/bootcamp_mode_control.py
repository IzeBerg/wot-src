import BigWorld, constants, Keys
from AvatarInputHandler.commands.input_handler_command import InputHandlerCommand

class BootcampModeControl(InputHandlerCommand):

    def handleKeyEvent(self, isDown, key, mods, event=None):
        playerBase = BigWorld.player().base
        if isDown and constants.HAS_DEV_RESOURCES:
            if key == Keys.KEY_F3:
                playerBase.setDevelopmentFeature(0, 'heal', 0, '')
                return True
            if key == Keys.KEY_F4:
                playerBase.setDevelopmentFeature(0, 'reload_gun', 0, '')
                return True
            if key == Keys.KEY_F5:
                playerBase.setDevelopmentFeature(0, 'teleportToShotPoint', 0, '')
                return True
            if key == Keys.KEY_P and BigWorld.isKeyDown(Keys.KEY_CAPSLOCK):
                playerBase.setDevelopmentFeature(0, 'kill_bots', 0, '')
                return True