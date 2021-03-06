from collections import namedtuple
import re
from gui.impl.gen import R
from gui.shared.gui_items import Vehicle
from helpers import dependency, int2roman
from skeletons.gui.impl import IGuiLoader
from skeletons.gui.shared import IItemsCache
SpecialRewardData = namedtuple('SpecialRewardData', ('sourceName', 'congratsSourceId',
                                                     'vehicleName', 'vehicleLvl',
                                                     'vehicleIsElite', 'vehicleType',
                                                     'goToVehicleBtn', 'videoShownKey'))

def getVehicleStrID(vehicleName):
    return vehicleName.split(':')[1]


def formatEliteVehicle(isElite, typeName):
    ubFormattedTypeName = Vehicle.getIconResourceName(typeName)
    if isElite:
        return ('{}_elite').format(ubFormattedTypeName)
    return ubFormattedTypeName


def loadedViewPredicate(layoutID):
    return lambda view: view.layoutID == layoutID


def showMarathonReward(vehicleCD, videoShownKey):
    from gui.impl.lobby.marathon.marathon_reward_view import MarathonRewardViewWindow
    uiLoader = dependency.instance(IGuiLoader)
    itemsCache = dependency.instance(IItemsCache)
    vehicle = itemsCache.items.getItemByCD(vehicleCD)
    if vehicle is not None:
        vehicleType = formatEliteVehicle(vehicle.isElite, vehicle.type)
        congratsSourceId = str(vehicle.intCD)
        sourceName = Vehicle.getIconResourceName(getVehicleStrID(vehicle.name))
        if sourceName and congratsSourceId is not None:
            specialRewardData = SpecialRewardData(sourceName=sourceName, congratsSourceId=congratsSourceId, vehicleName=vehicle.userName, vehicleIsElite=vehicle.isElite, vehicleLvl=int2roman(vehicle.level), vehicleType=vehicleType, goToVehicleBtn=vehicle.isInInventory, videoShownKey=videoShownKey)
            viewID = R.views.lobby.marathon.marathon_reward_view.MarathonRewardView()
            if uiLoader.windowsManager.findViews(loadedViewPredicate(viewID)):
                return
            window = MarathonRewardViewWindow(specialRewardData)
            window.load()
    return


def getRewardImage(path):
    if path is None:
        return ''
    else:
        return path.replace('../', 'img://gui/')


def getRewardLabel(label):
    if label is None:
        return ''
    else:
        return re.sub('\\D', '', label)


def getRewardOverlayType(overlayType):
    label = overlayType['big'] if overlayType else ''
    return label.replace('Big', '')