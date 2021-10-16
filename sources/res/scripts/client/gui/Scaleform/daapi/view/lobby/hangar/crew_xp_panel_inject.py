from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.lobby.crew.crew_header_view import CrewHeaderView
from gui.Scaleform.daapi.view.meta.CrewXPPanelInjectMeta import CrewXPPanelInjectMeta
from gui.prb_control.entities.listener import IGlobalListener

class CrewXPPanelInject(InjectComponentAdaptor, CrewXPPanelInjectMeta, IGlobalListener):

    def _makeInjectView(self):
        return CrewHeaderView()