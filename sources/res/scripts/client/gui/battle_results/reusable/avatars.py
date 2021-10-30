import typing
from gui.battle_results.reusable import shared
from gui.doc_loaders.badges_loader import getSelectedByLayout
from gui.shared.badges import buildBadge

class AvatarInfo(shared.ItemInfo):
    __slots__ = ('__totalDamaged', '__avatarKills', '__avatarDamaged', '__avatarDamageDealt',
                 '__badge', '__suffixBadge', '__fairplayViolations', '__accRank',
                 '__prevAccRank', '__extInfo', '__badgesInfo', '__weakref__')

    def __init__(self, totalDamaged=0, avatarKills=0, avatarDamaged=0, avatarDamageDealt=0, fairplayViolations=None, wasInBattle=True, accRank=None, prevAccRank=None, badges=(), **kwargs):
        super(AvatarInfo, self).__init__(wasInBattle=wasInBattle)
        self.__totalDamaged = totalDamaged
        self.__avatarKills = avatarKills
        self.__avatarDamaged = avatarDamaged
        self.__avatarDamageDealt = avatarDamageDealt
        self.__fairplayViolations = shared.FairplayViolationsInfo(*(fairplayViolations or ()))
        self.__accRank = accRank
        self.__prevAccRank = prevAccRank
        if badges:
            self.__badge, self.__suffixBadge = getSelectedByLayout(badges[0])
            self.__badgesInfo = badges[1]
        else:
            self.__badge, self.__suffixBadge, self.__badgesInfo = (0, 0, None)
        self.__extInfo = kwargs
        return

    @property
    def totalDamaged(self):
        return self.__totalDamaged

    @property
    def avatarKills(self):
        return self.__avatarKills

    @property
    def avatarDamaged(self):
        return self.__avatarDamaged

    @property
    def avatarDamageDealt(self):
        return self.__avatarDamageDealt

    def hasPenalties(self):
        return self.__fairplayViolations.hasPenalties()

    def getPenaltyName(self):
        return self.__fairplayViolations.getPenaltyName()

    @property
    def accRank(self):
        if self.__accRank:
            return self.__accRank[0]
        return 0

    @property
    def extensionInfo(self):
        return self.__extInfo

    @property
    def prevAccRank(self):
        if self.__prevAccRank:
            return self.__prevAccRank[0]
        return 0

    @property
    def badge(self):
        return self.__badge

    @property
    def suffixBadge(self):
        return self.__suffixBadge

    def getFullBadgeInfo(self):
        return buildBadge(self.badge, extraData=self.__badgesInfo)


class AvatarsInfo(shared.UnpackedInfo):
    __slots__ = ('__avatars', )

    def __init__(self, avatars):
        super(AvatarsInfo, self).__init__()
        self.__avatars = {}
        for dbID, data in avatars.iteritems():
            if data is None:
                self._addUnpackedItemID(dbID)
                data = {}
            self.__avatars[dbID] = AvatarInfo(**data)

        return

    def getAvatarInfo(self, dbID):
        if dbID in self.__avatars:
            info = self.__avatars[dbID]
        else:
            self.__avatars[dbID] = info = AvatarInfo(wasInBattle=False)
        return info