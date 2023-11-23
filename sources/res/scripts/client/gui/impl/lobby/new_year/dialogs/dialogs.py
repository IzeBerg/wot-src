from wg_async import wg_async, wg_await
from BWUtil import AsyncReturn
from gui.impl.dialogs import dialogs

@wg_async
def showBuyDialog(window):
    result = yield wg_await(dialogs.show(window))
    raise AsyncReturn(result)