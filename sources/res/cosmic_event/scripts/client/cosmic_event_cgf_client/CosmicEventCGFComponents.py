import CGF, GenericComponents
from cgf_script.component_meta_class import ComponentProperty, CGFMetaTypes, registerComponent
from cosmic_event_common.cosmic_constants import COSMIC_CGF_CATEGORY

@registerComponent
class CosmicFragmentHologram(object):

    def __init__(self):
        self.partialFunc = None
        return

    category = COSMIC_CGF_CATEGORY
    domain = CGF.DomainOption.DomainClient
    animator = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Animator', value=GenericComponents.AnimatorComponent)


@registerComponent
class CosmicRenderTypeComponent(object):
    editorTitle = 'CosmicDeferredRenderComponent'
    category = COSMIC_CGF_CATEGORY
    domain = CGF.DomainOption.DomainClient | CGF.DomainOption.DomainEditor
    showInDeferred = ComponentProperty(type=CGFMetaTypes.BOOL, editorName='show in deferred', value=False)
    showInForward = ComponentProperty(type=CGFMetaTypes.BOOL, editorName='show in forward', value=False)