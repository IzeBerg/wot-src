from gui.Scaleform.managers.windows_stored_data import DATA_TYPE, TARGET_ID
from gui.Scaleform.managers.windows_stored_data import stored_window
from messenger.gui.Scaleform.view.lobby.SimpleChannelWindow import SimpleChannelWindow

@stored_window(DATA_TYPE.CAROUSEL_WINDOW, TARGET_ID.CHANNEL_CAROUSEL)
class LazyChannelWindow(SimpleChannelWindow):
    pass