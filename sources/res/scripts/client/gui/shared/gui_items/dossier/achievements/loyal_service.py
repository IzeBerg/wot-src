from gui.impl import backport
from gui.shared.gui_items.dossier.achievements.abstract import DeprecatedAchievement
from helpers import i18n

class LoyalServiceAchievement(DeprecatedAchievement):

    def __init__(self, name, block, dossier, value=None):
        super(LoyalServiceAchievement, self).__init__(name, block, dossier, value)
        if dossier is not None:
            self.__registrationDate = backport.getLongDateFormat(dossier.getDossierDescr()['total']['creationTime'])
        else:
            self.__registrationDate = None
        return

    def getUserDescription(self):
        if self.__registrationDate:
            return i18n.makeString(('#achievements:{}_descr').format(self._getActualName()), regDate=self.__registrationDate)
        return ''