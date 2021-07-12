from messenger import MessengerEntry

class messengerEntryProperty(property):

    def __get__(self, obj, objType=None):
        return MessengerEntry.g_instance


class channelsCtrlProperty(property):

    def __get__(self, obj, objType=None):
        return MessengerEntry.g_instance.gui.channelsCtrl