from ClientSelectableObject import ClientSelectableObject
from gui.shared import g_eventBus, events

class ClientSelectableWebLinksOpener(ClientSelectableObject):

    def onMouseClick(self):
        super(ClientSelectableWebLinksOpener, self).onMouseClick()
        if self.url:
            g_eventBus.handleEvent(events.OpenLinkEvent(events.OpenLinkEvent.PARSED, url=self.url))