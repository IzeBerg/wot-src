import CGF
from cgf_script.component_meta_class import ComponentProperty, CGFMetaTypes, registerComponent

@registerComponent
class EquipmentAnimatorTrigger(object):
    domain = CGF.DomainOption.DomainClient | CGF.DomainOption.DomainEditor
    activeTrigger = ComponentProperty(type=CGFMetaTypes.STRING, value='', editorName='active trigger name')
    inactiveTrigger = ComponentProperty(type=CGFMetaTypes.STRING, value='', editorName='inactive trigger name')


class EquipmentStateComponent(object):
    state = property(lambda self: self.__state)

    def __init__(self, state):
        self.__state = state


class EquipmentTrackerComponent(object):

    def __init__(self):
        self.__equipmentGameObjects = {}
        self.__reservedIDs = set()

    def reserveID(self, equipmentID):
        self.__reservedIDs.add(equipmentID)

    def isReserved(self, equipmentID):
        return equipmentID in self.__reservedIDs

    def startTrack(self, equipmentID, gameObject):
        self.__equipmentGameObjects[equipmentID] = gameObject

    def getEquipmentGameObject(self, equipmentID):
        return self.__equipmentGameObjects.get(equipmentID, None)