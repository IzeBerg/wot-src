from gui.Scaleform.daapi.view.battle.shared.crosshair import CrosshairPanelContainer
from white_tiger.gui.Scaleform.daapi.view.battle.white_tiger.crosshair import plugins

class WhiteTigerCrosshairPanelContainer(CrosshairPanelContainer):

    def __init__(self):
        super(WhiteTigerCrosshairPanelContainer, self).__init__()
        self.addPlugins(plugins.createPlugins())