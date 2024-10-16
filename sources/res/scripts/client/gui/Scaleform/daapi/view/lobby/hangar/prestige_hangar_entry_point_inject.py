from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.lobby.prestige.prestige_hangar_entry_point_view import PrestigeHangarEntryPointView
from gui.Scaleform.daapi.view.meta.PrestigeProgressInjectMeta import PrestigeProgressInjectMeta
from gui.prb_control.entities.listener import IGlobalListener
from shared_utils import nextTick

class PrestigeHangarEntryPointInject(InjectComponentAdaptor, PrestigeProgressInjectMeta, IGlobalListener):

    @nextTick
    def _createInjectView(self, *args):
        super(PrestigeHangarEntryPointInject, self)._createInjectView(*args)

    def _makeInjectView(self):
        return PrestigeHangarEntryPointView()