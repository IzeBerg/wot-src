from gui.Scaleform.daapi.view.meta.AlertMessageBlockMeta import AlertMessageBlockMeta

class AlertMessageBlock(AlertMessageBlockMeta):

    def __init__(self):
        super(AlertMessageBlock, self).__init__()
        self.__onBtnClickCallback = None
        return

    def update(self, alertMsgData, onBtnClickCallback=None):
        self.__onBtnClickCallback = onBtnClickCallback
        self.as_setDataS(alertMsgData)

    def onButtonClick(self):
        if self.__onBtnClickCallback:
            self.__onBtnClickCallback()

    def _dispose(self):
        super(AlertMessageBlock, self)._dispose()
        self.__onBtnClickCallback = None
        return