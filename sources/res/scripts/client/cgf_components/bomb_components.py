import Triggers
from cgf_script.component_meta_class import CGFComponent, ComponentProperty, CGFMetaTypes

class BombAbsorptionAreaComponent(CGFComponent):
    category = 'GameLogic'
    trigger = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Trigger', value=Triggers.AreaTriggerComponent)