import Triggers, CGF
from cgf_script.component_meta_class import ComponentProperty, CGFMetaTypes, registerComponent
from cosmic_event_common.cosmic_constants import COSMIC_CGF_CATEGORY

@registerComponent
class CosmicDeathAreaTrigger(object):
    LAVA_POOL_ZONE = 'lavaPool'
    OUTLAND_ZONE = 'outland'
    AVAILABLE_ZONE_TYPES = (LAVA_POOL_ZONE, OUTLAND_ZONE)

    def __init__(self):
        self.reactionID = None
        return

    category = COSMIC_CGF_CATEGORY
    domain = CGF.DomainOption.DomainAll
    trigger = ComponentProperty(type=CGFMetaTypes.LINK, editorName='AreaTrigger', value=Triggers.AreaTriggerComponent)
    zoneType = ComponentProperty(type=CGFMetaTypes.STRING, editorName='ZoneType', value='')