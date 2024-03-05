from helpers import dependency
from skeletons.gui.game_control import IReferralProgramController
from web.web_client_api import w2c, W2CSchema

class ReferralProgramPagesMixin(object):
    __referralCtrl = dependency.descriptor(IReferralProgramController)

    @w2c(W2CSchema, 'referral_program_view')
    def openReferralProgramView(self, _):
        if self.__referralCtrl and self.__referralCtrl.isEnabled():
            self.__referralCtrl.showWindow()
        return {'success': self.__referralCtrl and self.__referralCtrl.isEnabled}