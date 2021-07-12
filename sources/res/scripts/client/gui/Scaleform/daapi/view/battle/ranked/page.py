from gui.Scaleform.daapi.view.battle.classic.page import ClassicPage
from gui.Scaleform.daapi.view.battle.shared.hint_panel.plugins import RoleHelpPlugin
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES

class RankedPage(ClassicPage):

    def _populate(self):
        super(RankedPage, self)._populate()
        if RoleHelpPlugin.isAvailableToShow():
            self.as_createRoleDescriptionS()
            self._blToggling.add(BATTLE_VIEW_ALIASES.ROLE_DESCRIPTION)