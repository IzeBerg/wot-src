from __future__ import absolute_import
from gui.impl import backport
from gui.impl.gen import R
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import TOOLTIP_TYPES
from gui.Scaleform.daapi.view.lobby.header.helpers.controls_helpers import DefaultLobbyHeaderHelper
from gui.shared.utils.functions import makeTooltip
from halloween.gui.scaleform.daapi.view.lobby.header.helpers.fight_btn_tooltips import getHalloweenFightButtonTooltipData

class HalloweenLobbyHeaderHelper(DefaultLobbyHeaderHelper):
    __slots__ = ()

    @classmethod
    def _getDisabledFightTooltipData(cls, prbValidation, isInSquad):
        return (getHalloweenFightButtonTooltipData(prbValidation, isInSquad), False)

    @classmethod
    def _getOutSquadTooltipData(cls, _):
        header = backport.text(R.strings.halloween_platoon.headerButton.tooltips.squad.header())
        body = backport.text(R.strings.halloween_platoon.headerButton.tooltips.squad.body())
        return (makeTooltip(header, body), TOOLTIP_TYPES.COMPLEX)