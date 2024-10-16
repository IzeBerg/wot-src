import BigWorld
from HWBuffPanelComponent import HWBuffPanelComponent
from gui.Scaleform.daapi.view.battle.shared.consumables_panel import TOOLTIP_FORMAT
from gui.impl.gen import R
from gui.impl import backport
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
from halloween.gui.scaleform.daapi.view.meta.BuffsPanelMeta import BuffsPanelMeta
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider

def prepareParams(params, withPrefix=False):
    res = {}
    for key, value in params:
        if value > 0 and withPrefix:
            res[key] = '+' + backport.getNiceNumberFormat(value)
        else:
            res[key] = backport.getNiceNumberFormat(value)

    return res


def findBuffsPanelComponents():
    player = BigWorld.player()
    if not player:
        return []
    vehicle = BigWorld.entities.get(player.playerVehicleID)
    if not vehicle:
        return []
    return [ c for c in vehicle.dynamicComponents.values() if isinstance(c, HWBuffPanelComponent) ]


class BuffsPanel(BuffsPanelMeta):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)
    ICONS_PATH = R.images.halloween.gui.maps.icons.battleBuffs.c_36x36
    TEXT_PATH = R.strings.halloween_buffs.buffs

    def __init__(self):
        super(BuffsPanel, self).__init__()
        self._buffs = set()
        self._buffsState = {}

    def _populate(self):
        super(BuffsPanel, self)._populate()
        hwBattleGuiCtrl = self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onApplyBuff += self.__handleBuffApply
            hwBattleGuiCtrl.onUnapplyBuff += self.__handleBuffUnApply
            hwBattleGuiCtrl.onBuffStateChanged += self.__handleBuffStateChanged
        self.__init()

    def _dispose(self):
        hwBattleGuiCtrl = self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onApplyBuff -= self.__handleBuffApply
            hwBattleGuiCtrl.onUnapplyBuff -= self.__handleBuffUnApply
            hwBattleGuiCtrl.onBuffStateChanged -= self.__handleBuffStateChanged
        self._buffs.clear()
        super(BuffsPanel, self)._dispose()

    def __init(self):
        buffComponents = findBuffsPanelComponents()
        for component in buffComponents:
            self.__addBuffToPanel(component.buffKey, component.params)

    def __handleBuffUnApply(self, ctx):
        buff = ctx['buffKey']
        if buff in self._buffs:
            self.as_removeBuffSlotS(buff)
            self._buffs.remove(buff)

    def __addBuffToPanel(self, buffKey, params):
        if buffKey in self._buffs:
            return
        headerRes = self.TEXT_PATH.dyn(buffKey).dyn('header')
        bodyRes = self.TEXT_PATH.dyn(buffKey).dyn('body')
        headerText = backport.text(headerRes()) if headerRes.exists() else ''
        bodyText = backport.text(bodyRes(), **prepareParams(params)) if bodyRes.exists() else ''
        tooltip = TOOLTIP_FORMAT.format(headerText, bodyText)
        iconRes = self.ICONS_PATH.dyn(buffKey)
        icon = backport.image(iconRes()) if iconRes.exists() else ''
        self._buffs.add(buffKey)
        self.as_addBuffSlotS(buffKey, icon, tooltip)
        if buffKey in self._buffsState:
            self.as_setBuffEnabledS(buffKey, self._buffsState[buffKey])

    def __handleBuffApply(self, ctx):
        self.__addBuffToPanel(ctx['buffKey'], ctx['params'])

    def __handleBuffStateChanged(self, ctx):
        buff = ctx['buffKey']
        state = ctx['isActive']
        self._buffsState[buff] = state
        self.as_setBuffEnabledS(buff, state)