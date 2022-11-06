from gui.impl.gen.resources import R
from gui.impl import backport
from gui.server_events import recruit_helper
from gui.shared.utils.functions import replaceHyphenToUnderscore

def getTitle(name=None):
    if name:
        title = backport.text(R.strings.dialogs.recruitDialog.name.title(), name=name)
    else:
        title = backport.text(R.strings.dialogs.recruitDialog.title())
    return title


def getIconName(iconID):
    return iconID.split('.')[0]


def getIcon(iconName='', isFemale=False):
    specialID = R.images.gui.maps.icons.tankmen.icons.special.dyn(attr=('{}').format(replaceHyphenToUnderscore(iconName)))
    if specialID is not None and specialID.exists():
        return (specialID(), True)
    else:
        bigID = R.images.gui.maps.icons.tankmen.icons.big.dyn(attr=('{}').format(replaceHyphenToUnderscore(iconName)))
        if bigID is not None and bigID.exists():
            return (bigID(), False)
        if isFemale:
            return (
             R.images.gui.maps.icons.tankmen.icons.special.dyn(replaceHyphenToUnderscore(getIconName(recruit_helper._TANKWOMAN_ICON)))(), True)
        return (
         R.images.gui.maps.icons.tankmen.icons.special.dyn(replaceHyphenToUnderscore(getIconName(recruit_helper._TANKMAN_ICON)))(), True)


def getIconBackground(resurceID=None):
    if resurceID in recruit_helper.RecruitSourceID.EVENTS:
        return R.images.gui.maps.icons.tankmen.windows.bg_recruitment_twitch()
    if resurceID and resurceID[:2] == 'ny':
        return R.images.gui.maps.icons.tankmen.windows.bg_recruitment_ny()
    return R.images.gui.maps.icons.tankmen.windows.bg_recruitment_regular()


def getSortedItems(unsortedItems, itemsOrderedList):
    sortedItems = []
    for name in itemsOrderedList:
        if name in unsortedItems:
            sortedItems.append(name)

    return sortedItems