import CGF
from cgf_components.hover_component import SelectionComponent
from cgf_script.component_meta_class import registerComponent
from cgf_script.managers_registrator import onAddedQuery, onRemovedQuery, registerRule, Rule, registerManager
from gui.prb_control.entities.listener import IGlobalListener
from helpers import dependency
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.skeletons.halloween_sound_controller import IHalloweenSoundController

@registerComponent
class HWShowEventComponent(object):
    domain = CGF.DomainOption.DomainClient
    editorTitle = 'HW Show Event Component'
    category = 'Halloween'
    halloweenCtrl = dependency.descriptor(IHalloweenController)
    hwSoundCtrl = dependency.descriptor(IHalloweenSoundController)

    def showEvent(self):
        if self.halloweenCtrl.isAvailable():
            self.hwSoundCtrl.playSoundEvent('ev_hw_hangar_3d_collector_stinger')
            self.halloweenCtrl.selectBattle()


class HWShowEventComponentManager(CGF.ComponentManager, IGlobalListener):
    halloweenCtrl = dependency.descriptor(IHalloweenController)

    @onAddedQuery(CGF.GameObject, HWShowEventComponent)
    def onShowEventAdded(self, gameObject, _):
        if self.prbDispatcher and not self.prbDispatcher.hasListener(self):
            self.startGlobalListening()
        if self.prbEntity is not None:
            self._updateGameObjectComponent(gameObject)
        return

    @onRemovedQuery(CGF.GameObject, HWShowEventComponent)
    def onShowEventRemoved(self, _, __):
        eventGameObjectsQuery = CGF.Query(self.spaceID, (CGF.GameObject, HWShowEventComponent))
        if eventGameObjectsQuery.empty() and self.prbDispatcher and self.prbDispatcher.hasListener(self):
            self.stopGlobalListening()

    @onAddedQuery(HWShowEventComponent, SelectionComponent)
    def onSelectionAdded(self, showEventComponent, selectionComponent):
        selectionComponent.onClickAction += showEventComponent.showEvent

    @onRemovedQuery(HWShowEventComponent, SelectionComponent)
    def onSelectionRemoved(self, showEventComponent, selectionComponent):
        selectionComponent.onClickAction -= showEventComponent.showEvent

    def onPrbEntitySwitched(self):
        if self.prbEntity is None or not self.prbDispatcher or not self.prbDispatcher.hasListener(self):
            return
        eventGameObjectsQuery = CGF.Query(self.spaceID, (CGF.GameObject, HWShowEventComponent))
        for eventGameObject, _ in eventGameObjectsQuery:
            self._updateGameObjectComponent(eventGameObject)

        return

    def _updateGameObjectComponent(self, eventGameObject):
        if self.halloweenCtrl.isEventHangar():
            if eventGameObject.findComponentByType(SelectionComponent) is not None:
                eventGameObject.removeComponentByType(SelectionComponent)
        elif eventGameObject.findComponentByType(SelectionComponent) is None:
            eventGameObject.createComponent(SelectionComponent)
        return


@registerRule
class HWShowEventRule(Rule):
    domain = CGF.DomainOption.DomainClient
    editorTitle = 'HW Show Event Rule'
    category = 'Halloween'

    @registerManager(HWShowEventComponentManager)
    def reg1(self):
        return