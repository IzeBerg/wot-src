from functools import partial
import CGF
from GenericComponents import DecalComponent, EntityGOSync
from cgf_script.component_meta_class import ComponentProperty, CGFMetaTypes, registerComponent
from cgf_script.managers_registrator import onAddedQuery, autoregister
from vehicle_systems.model_assembler import loadAppearancePrefab

@registerComponent
class SerialNumberSwitcher(object):
    domain = CGF.DomainOption.DomainClient
    lamp3digits = ComponentProperty(type=CGFMetaTypes.STRING, editorName='3 digits', annotations={'path': '*.prefab'})
    lamp4digits = ComponentProperty(type=CGFMetaTypes.STRING, editorName='4 digits', annotations={'path': '*.prefab'})
    lamp5digits = ComponentProperty(type=CGFMetaTypes.STRING, editorName='5 digits', annotations={'path': '*.prefab'})

    def getPrefabPath(self, counterValue):
        length = len(counterValue)
        if length > 4:
            return self.lamp5digits
        if length > 3:
            return self.lamp4digits
        return self.lamp3digits


@registerComponent
class SerialNumberComponent(object):
    domain = CGF.DomainOption.DomainClient
    counterValue = ComponentProperty(type=CGFMetaTypes.STRING, editorName='Counter Value', value='00000')
    splitNumber = ComponentProperty(type=CGFMetaTypes.BOOL, editorName='Split number', value=False)
    decalComponent = ComponentProperty(type=CGFMetaTypes.LINK, editorName='DecalLink', value=DecalComponent)
    decalCount = ComponentProperty(type=CGFMetaTypes.INT, editorName='Decal count', value=1)


@autoregister(presentInAllWorlds=True)
class SerialNumberComponentManager(CGF.ComponentManager):
    DEFAULT_NUMBER = '00000'

    @onAddedQuery(SerialNumberSwitcher, CGF.GameObject)
    def onAddedSwitcher(self, switcher, gameObject):
        vehicle = self.__getVehicle(gameObject)
        if vehicle is not None:
            counterVaue = self.__getSerialNumberValue(vehicle)
            prefabPath = switcher.getPrefabPath(counterVaue)
            loadAppearancePrefab(prefabPath, vehicle.appearance, partial(self.__onLoaded, counterVaue))
        return

    @onAddedQuery(SerialNumberComponent, CGF.GameObject)
    def onAdded(self, serialNumber, gameObject):
        vehicle = self.__getVehicle(gameObject)
        counterValue = self.__getSerialNumberValue(vehicle)
        if serialNumber.decalComponent is not None and serialNumber.decalComponent() is not None:
            if serialNumber.splitNumber:
                for i in xrange(0, len(counterValue)):
                    serialNumber.decalComponent().setCounterStickerValue(i, counterValue[i])

            else:
                for i in xrange(0, serialNumber.decalCount):
                    serialNumber.decalComponent().setCounterStickerValue(i, counterValue)

        return

    def __onLoaded(self, counterValue, gameObject):
        serialNumber = gameObject.findComponentByType(SerialNumberComponent)
        if serialNumber is not None:
            serialNumber.counterValue = counterValue
        return

    def __getVehicle(self, gameObject):
        hierarchy = CGF.HierarchyManager(self.spaceID)
        rootGameObject = hierarchy.getTopMostParent(gameObject)
        goSyncComponent = rootGameObject.findComponentByType(EntityGOSync)
        if goSyncComponent is None:
            return
        else:
            return goSyncComponent.entity

    def __getSerialNumberValue(self, vehicle):
        counterValue = str()
        if vehicle is not None:
            counterValue = vehicle.appearance.outfit.serialNumber
        if counterValue:
            return counterValue
        else:
            return self.DEFAULT_NUMBER