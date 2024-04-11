from gui.Scaleform.daapi.view.lobby.missions import g_missionInfoMapList

class MissionInfoMap(object):
    __slots__ = ('questPrefix', 'infoClass', 'detailedInfoClass')

    def __init__(self, questPrefix, infoClass, detailedInfoClass):
        self.questPrefix = questPrefix
        self.infoClass = infoClass
        self.detailedInfoClass = detailedInfoClass


def extendMissionInfoMap(questPrefix, infoClass, detailedInfoClass):
    infoMap = MissionInfoMap(questPrefix, infoClass, detailedInfoClass)
    g_missionInfoMapList.append(infoMap)