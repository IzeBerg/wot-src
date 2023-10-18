import BigWorld
from gui import makeHtmlString
from gui.battle_control.controllers.battle_hints_ctrl import BattleHintComponent
from gui.impl.gen import R
from gui.impl import backport
from halloween.gui.scaleform.daapi.view.battle.buffs_panel import prepareParams, findBuffsPanelComponents
from halloween.gui.scaleform.daapi.view.meta.BuffNotificationSystemMeta import BuffNotificationSystemMeta
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID

class BuffsNotificationSystem(BattleHintComponent, BuffNotificationSystemMeta):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)
    ICONS_PATH = R.images.halloween.gui.maps.icons.battleBuffs.c_58x58
    TEXT_PATH = R.strings.halloween_buffs.buffs
    STYLE_BOLD_PARAM = 'boldTitle'
    STYLE_DESCRIPTION = 'hwBuffDescriptor'
    BATTLE_HINT_TEMPLATE = 'buffNotification'
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(BuffsNotificationSystem, self).__init__()
        self.ignoreNotification = set()
        self._currentBuffKey = None
        return

    def _populate(self):
        self.ignoreNotification = set([ c.buffKey for c in findBuffsPanelComponents() ])

    def _dispose(self):
        self.ignoreNotification.clear()

    def _showHint(self, hint, data):
        buffKey = data['buffKey']
        if buffKey in self.ignoreNotification:
            return
        player = BigWorld.player()
        if not (player and player.isVehicleAlive):
            return
        self.ignoreNotification.add(buffKey)
        params = prepareParams(data['params'])
        titleRes = self.TEXT_PATH.dyn(buffKey).dyn('header')
        hintData = {'iconSource': backport.image(self.ICONS_PATH.dyn(buffKey)()), 
           'title': backport.text(titleRes()) if titleRes.exists() else ''}
        descriptions = self.TEXT_PATH.dyn(buffKey).dyn('description')
        values = self.TEXT_PATH.dyn(buffKey).dyn('value')
        info = []
        for idx in xrange(1, descriptions.length() + 1):
            value = self.__makeHtmlFormat(backport.text(values.num(idx)(), **params), self.STYLE_BOLD_PARAM) if values.num(idx).exists() else ''
            info.append(self.__makeHtmlFormat(backport.text(descriptions.num(idx)(), value=value), self.STYLE_DESCRIPTION))

        hintData.update({'info': info})
        self._currentBuffKey = buffKey
        hwBattleGuiCtrl = self.sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onShowPanelBuffNotification(True)
        self.as_showBuffNotificationS(hintData)

    def _hideHint(self):
        self.ignoreNotification.discard(self._currentBuffKey)
        hwBattleGuiCtrl = self.sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onShowPanelBuffNotification(False)
        self.as_hideBuffNotificationS()

    def __makeHtmlFormat(self, text, format):
        return makeHtmlString('html_templates:battle/textStyle', format, {'text': text})