from frameworks.wulf import ViewFlags
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.prb_control.entities.listener import IGlobalListener
from gui.impl.lobby.bootcamp.bootcamp_progress_widget_view import BootcampProgressWidgetView
from gui.Scaleform.daapi.view.meta.BootcampProgressMeta import BootcampProgressMeta

class BootcampProgressComponent(InjectComponentAdaptor, BootcampProgressMeta, IGlobalListener):

    def _makeInjectView(self):
        return BootcampProgressWidgetView(flags=ViewFlags.VIEW)