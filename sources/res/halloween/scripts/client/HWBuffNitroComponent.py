import weakref
from dyn_components_groups import groupComponent
from script_component.DynamicScriptComponent import DynamicScriptComponent
from xml_config_specs import IntParam
_NITRO_APPEARED = 1
_NITRO_HIDDEN = 0

@groupComponent(nitro=IntParam())
class HWBuffNitroComponent(DynamicScriptComponent):

    def __init__(self):
        super(HWBuffNitroComponent, self).__init__()
        self._appearanceRef = weakref.ref(self.entity.appearance)

    def _onAvatarReady(self):
        super(HWBuffNitroComponent, self)._onAvatarReady()
        nitro = getattr(self.groupComponentConfig, 'nitro', _NITRO_APPEARED)
        self._setType(nitro)

    def onDestroy(self):
        self._setType(_NITRO_HIDDEN)
        super(HWBuffNitroComponent, self).onDestroy()

    def _setType(self, nitro):
        appearance = self._appearanceRef()
        if appearance is not None:
            effectMgr = appearance.customEffectManager
            if effectMgr is not None:
                effectMgr.variables['Nitro'] = nitro
        return