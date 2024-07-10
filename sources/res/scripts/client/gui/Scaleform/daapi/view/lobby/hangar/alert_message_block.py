from gui.Scaleform.daapi.view.meta.AlertMessageBlockMeta import AlertMessageBlockMeta

class AlertMessageBlock(AlertMessageBlockMeta):

    def __init__(self):
        super(AlertMessageBlock, self).__init__()
        self.__onBtnClickCallback = None
        self.__onBlockClickCallback = None
        return

    def update(self, alertMsgData, callbacks=None):
        callbacks = callbacks or {}
        self.__onBtnClickCallback = callbacks.get('onButtonClick')
        self.__onBlockClickCallback = callbacks.get('onBlockClick')
        self.as_setDataS(alertMsgData)

    def onBlockClick(self):
        if self.__onBlockClickCallback:
            self.__onBlockClickCallback()

    def onButtonClick(self):
        if self.__onBtnClickCallback:
            self.__onBtnClickCallback()

    def _dispose(self):
        super(AlertMessageBlock, self)._dispose()
        self.__onBtnClickCallback = None
        self.__onBlockClickCallback = None
        return