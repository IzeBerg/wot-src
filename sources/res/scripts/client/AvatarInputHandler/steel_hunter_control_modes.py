from AvatarInputHandler.control_modes import PostMortemControlMode

class SHPostMortemControlMode(PostMortemControlMode):

    def _isPostmortemDelayEnabled(self):
        return False