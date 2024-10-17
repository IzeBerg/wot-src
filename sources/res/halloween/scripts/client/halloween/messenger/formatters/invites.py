from gui.prb_control.formatters.invites import PrbInviteHtmlTextFormatter
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency

class HalloweenPrbInviteHtmlTextFormatter(PrbInviteHtmlTextFormatter):
    __halloweenCtrl = dependency.descriptor(IHalloweenController)

    def canAcceptInvite(self, invite):
        canAccept = super(HalloweenPrbInviteHtmlTextFormatter, self).canAcceptInvite(invite)
        return canAccept and self.__halloweenCtrl.isAvailable()