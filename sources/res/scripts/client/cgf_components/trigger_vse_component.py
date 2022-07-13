import CGF, Event
from GenericComponents import VSEComponent
from cgf_script.component_meta_class import CGFComponent, ComponentProperty, CGFMetaTypes
from cgf_script.managers_registrator import autoregister, onAddedQuery, onRemovedQuery

class TriggerVSEComponent(CGFComponent):
    eventName = ComponentProperty(type=CGFMetaTypes.STRING, editorName='event name', value='event')

    def __init__(self):
        super(TriggerVSEComponent, self).__init__()
        self.triggerEvent = Event.Event()


@autoregister(presentInAllWorlds=False, category='lobby')
class TriggerVSEComponentsManager(CGF.ComponentManager):

    @onAddedQuery(TriggerVSEComponent, VSEComponent)
    def handleComponentAdded(self, triggerVseComponent, vseComponent):
        self.doAction(triggerVseComponent.eventName)
        triggerVseComponent.triggerEvent += vseComponent.context.onTriggerEvent

    @onRemovedQuery(TriggerVSEComponent, VSEComponent)
    def handleComponentRemoved(self, triggerVseComponent, vseComponent):
        triggerVseComponent.triggerEvent -= vseComponent.context.onTriggerEvent