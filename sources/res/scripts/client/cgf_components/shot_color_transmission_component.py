import CGF
from cgf_script.component_meta_class import CGFMetaTypes, ComponentProperty, registerComponent

@registerComponent
class ShotColorTransmissionComponent(object):
    editorTitle = 'Gun Shot Effect Component'
    category = 'Animator Triggers'
    domain = CGF.DomainOption.DomainClient | CGF.DomainOption.DomainEditor
    materialParam = ComponentProperty(type=CGFMetaTypes.STRING, editorName='material property', value='TintColor')
    startValue = ComponentProperty(type=CGFMetaTypes.FLOAT, editorName='start value', value=0.0)
    endValue = ComponentProperty(type=CGFMetaTypes.FLOAT, editorName='end value', value=0.5)