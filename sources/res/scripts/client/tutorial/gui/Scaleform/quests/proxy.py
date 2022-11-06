from tutorial.gui import GUI_EFFECT_NAME
from tutorial.gui.Scaleform import effects_player
from tutorial.gui.Scaleform.lobby.proxy import SfLobbyProxy
from tutorial.gui.Scaleform.quests import settings

class SfQuestsProxy(SfLobbyProxy):

    def __init__(self):
        effects = {GUI_EFFECT_NAME.SHOW_WINDOW: effects_player.ShowWindowEffect(settings.WINDOW_ALIAS_MAP), 
           GUI_EFFECT_NAME.UPDATE_CONTENT: effects_player.UpdateContentEffect(), 
           GUI_EFFECT_NAME.SHOW_HINT: effects_player.ShowChainHint()}
        super(SfQuestsProxy, self).__init__(effects_player.EffectsPlayer(effects))

    def getViewSettings(self):
        return settings.QUESTS_VIEW_SETTINGS

    def getViewsAliases(self):
        return settings.WINDOW_ALIAS_MAP