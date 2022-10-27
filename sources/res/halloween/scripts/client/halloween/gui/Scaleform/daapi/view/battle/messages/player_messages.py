from gui.doc_loaders import messages_panel_reader
from gui.Scaleform.daapi.view.battle.shared.messages import player_messages

class HalloweenPlayerMessages(player_messages.PlayerMessages):
    HW_XML_PATH = 'halloween/gui/player_messages_panel.xml'

    def _populate(self):
        super(HalloweenPlayerMessages, self)._populate()
        _, _, messages = messages_panel_reader.readXML(self.HW_XML_PATH)
        self._messages.update(messages)