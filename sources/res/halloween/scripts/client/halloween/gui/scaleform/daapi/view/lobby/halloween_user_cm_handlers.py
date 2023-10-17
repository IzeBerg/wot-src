import adisp
from wg_async import wg_await
from frameworks.wulf import WindowLayer
from gui.Scaleform.daapi.view.lobby.rally.UnitUserCMHandler import UnitUserCMHandler
from gui.Scaleform.daapi.view.lobby.user_cm_handlers import USER
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.pub.fade_manager import FadeManager
from gui.prb_control.entities.base.ctx import PrbAction
from halloween.gui.halloween_gui_constants import PREBATTLE_ACTION_NAME
from halloween.gui.shared.event_dispatcher import showHangarAsync
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween_common.halloween_constants import PREBATTLE_TYPE
from helpers import dependency
from shared_utils import findFirst
CREATE_HALLOWEEN_SQUAD = 'createHalloweenSquad'
EXCLUDE_CM_CLASS = (UnitUserCMHandler,)

@adisp.adisp_process
@dependency.replace_none_kwargs(ctrl=IHalloweenController)
def createHalloweenSquadHandler(cm, ctrl=None):
    if not ctrl.isEventHangar():
        action = PrbAction(PREBATTLE_ACTION_NAME.HALLOWEEN_SQUAD, accountsToInvite=[cm.databaseID])
        with FadeManager(WindowLayer.SERVICE_LAYOUT) as (fadeManager):
            result = yield ctrl.prbDispatcher.doSelectAction(action, transition=wg_await(fadeManager.show()))
            if not result:
                return
            yield showHangarAsync()
            yield wg_await(fadeManager.hide())
    else:
        cm.doSelect(PREBATTLE_ACTION_NAME.HALLOWEEN_SQUAD, (cm.databaseID,))


@dependency.replace_none_kwargs(ctrl=IHalloweenController)
def halloweenSquadOptionBuilder(cm, options, userCMInfo, ctrl=None):
    if userCMInfo.isIgnored or cm.isSquadCreator() or cm.prbDispatcher is None or isinstance(cm, EXCLUDE_CM_CLASS):
        return options
    if ctrl.isAvailable() and not cm.isSquadAlreadyCreated(PREBATTLE_TYPE.HALLOWEEN):
        canCreate = not cm.prbEntity.isInQueue()
        item = cm.makeItem(CREATE_HALLOWEEN_SQUAD, backport.text(R.strings.halloween_menu.contextMenu.createHalloweenSquad()), optInitData={'enabled': canCreate, 'textColor': 13347959})
        squadItem = findFirst(lambda it: it['id'] == USER.CREATE_SQUAD, options)
        inviteItem = findFirst(lambda it: it['id'] == USER.INVITE, options)
        userNameItem = findFirst(lambda it: it['id'] == USER.COPY_TO_CLIPBOARD, options)
        if squadItem:
            options.insert(options.index(squadItem) + 1, item)
        elif inviteItem:
            options.insert(options.index(inviteItem), item)
        elif userNameItem:
            options.insert(options.index(userNameItem) + 1, item)
    return options