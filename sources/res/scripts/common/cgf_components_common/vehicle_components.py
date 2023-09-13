import CGF, Triggers
from cgf_script.component_meta_class import ComponentProperty, CGFMetaTypes, registerComponent

@registerComponent
class VehicleDestroyingComponent(object):
    category = 'Vehicle'
    editorTitle = 'Vehicle Destroying Component'
    domain = CGF.DomainOption.DomainServer | CGF.DomainOption.DomainEditor
    trigger = ComponentProperty(type=CGFMetaTypes.LINK, editorName='AreaTrigger to subscribe', value=Triggers.AreaTriggerComponent)

    def __init__(self):
        self.reactionID = None
        return


@registerComponent
class VehicleDamageLoggerComponent(object):
    category = 'Loggers'
    editorTitle = 'Vehicle Damage Logger Component'
    domain = CGF.DomainOption.DomainServer | CGF.DomainOption.DomainEditor

    def __init__(self):
        self.topMostParentName = None
        return