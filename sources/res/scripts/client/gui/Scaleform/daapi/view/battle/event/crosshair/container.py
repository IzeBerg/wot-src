from gui.Scaleform.daapi.view.battle.event.crosshair import plugins
from gui.Scaleform.daapi.view.battle.shared.crosshair import CrosshairPanelContainer

class EventCrosshairPanelContainer(CrosshairPanelContainer):

    def __init__(self):
        super(EventCrosshairPanelContainer, self).__init__()
        self.addPlugins(plugins.createPlugins())