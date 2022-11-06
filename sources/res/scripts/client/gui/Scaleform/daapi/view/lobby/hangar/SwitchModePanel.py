from gui.Scaleform.daapi.view.meta.SwitchModePanelMeta import SwitchModePanelMeta

class SwitchModePanel(SwitchModePanelMeta):

    def _populate(self):
        super(SwitchModePanel, self)._populate()
        self.as_setVisibleS(False)

    def onSelectCheckBoxAutoSquad(self, isSelected):
        pass