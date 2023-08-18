import BattleReplay
from debug_utils import LOG_DEBUG, LOG_ERROR
from gui import SystemMessages
from messenger import g_settings
from messenger.ext import isBattleChatEnabled
from messenger.ext.player_helpers import isCurrentPlayer
from messenger.formatters.chat_message import LobbyMessageBuilder
from messenger.gui import events_dispatcher
from messenger.gui.Scaleform import FILL_COLORS
from messenger.gui.Scaleform.data.MembersDataProvider import MembersDataProvider
from messenger.gui.interfaces import IChannelController, IBattleChannelView

class LobbyLayout(IChannelController):

    def __init__(self, channel, mBuilder=None):
        self._views = []
        self._mBuilder = mBuilder or LobbyMessageBuilder()
        self._membersDP = None
        self._channel = channel
        self._activated = False
        self._isNotifyInit = False
        self._isNotifyDestroy = False
        self._addListeners()
        self._memInputText = ''
        return

    def __del__(self):
        LOG_DEBUG('Channel controller deleted:', self)

    def getMemInputText(self):
        return self._memInputText

    def setMemInputText(self, message):
        self._memInputText = message

    def getChannel(self):
        return self._channel

    def activate(self):
        self._activated = True

    def deactivate(self, entryClosing=False):
        self.removeView()
        self._activated = False

    def setView(self, view):
        self._views.append(view)
        view.onDispose += self._onModuleDispose
        view.setController(self)

    def removeView(self):
        for view in self._views:
            view.removeController()
            view.onDispose -= self._onModuleDispose
            view = None

        return

    def clear(self):
        self._fireDestroyEvent()
        self._removeListeners()
        self._channel = None
        self._mBuilder = None
        self.removeView()
        self.removeMembersDP()
        return

    def isJoined(self):
        return self._channel.isJoined()

    def setHistory(self, history):
        if self._channel:
            self._channel.clearHistory()
            for message in history:
                self.addMessage(message)

    def getHistory(self):
        if self._channel:
            return self._channel.getHistory()
        return []

    def setMembersDP(self, membersDP):
        if self._membersDP:
            LOG_ERROR('Member data provider is defined', self._membersDP)
        elif isinstance(membersDP, MembersDataProvider):
            self._membersDP = membersDP
            self._membersDP.buildList(self._channel.getMembers())
            self._membersDP.refresh()
        else:
            LOG_ERROR('Member data provide must be extends MembersDataProvider', membersDP)

    def removeMembersDP(self):
        if self._membersDP is not None:
            self._membersDP.destroy()
            self._membersDP = None
        return

    def sendMessage(self, message):
        result, errorMsg = self.canSendMessage()
        if result:
            self._broadcast(message)
        else:
            SystemMessages.pushI18nMessage(errorMsg, type=SystemMessages.SM_TYPE.Error)
        return result

    def addMessage(self, message, doFormatting=True):
        shouldAddTextLink = self._channel.isPrivate() and not isCurrentPlayer(message.accountDBID)
        text = self._format(message, doFormatting, shouldAddTextLink)
        if self._activated:
            for view in self._views:
                view.as_addMessageS(text)

        else:
            self._channel.addUnreadMessage(message)
        self._channel.addMessage(text)
        return self._activated

    def addCommand(self, command):
        text = command.getCommandText()
        if self._activated:
            for view in self._views:
                view.addCommand(command)
                view.as_addMessageS(text)

        return text

    def fireInitEvent(self):
        if not self._isNotifyInit:
            self._fireInitEvent()
            self._isNotifyInit = True

    def fireDestroyEvent(self):
        if not self._isNotifyDestroy:
            self._fireDestroyEvent()
            self._isNotifyDestroy = True

    def _onModuleDispose(self, view):
        view.removeController()
        view.onDispose -= self._onModuleDispose
        self._views.remove(view)

    def _refreshMembersDP(self):
        if self._membersDP:
            self._membersDP.buildList(self._channel.getMembers())
            self._membersDP.refresh()

    def _updatePrivateCarouselMembers(self):
        if not self._channel.isPrivate():
            return
        for member in self._channel.getMembers():
            memberDBID = member.getDatabaseID()
            if isCurrentPlayer(memberDBID):
                continue
            clientID = self._channel.getClientID()
            memberUsername = member.getFullName()
            events_dispatcher.updatePrivateCarouselMembers(clientID, memberDBID, memberUsername)
            break

    def _broadcast(self, message):
        raise NotImplementedError

    def _format(self, message, doFormatting=True, addTextLink=False):
        raise NotImplementedError

    def _fireInitEvent(self):
        pass

    def _fireDestroyEvent(self):
        pass

    def _addListeners(self):
        pass

    def _removeListeners(self):
        pass


class BattleLayout(IChannelController):

    def __init__(self, channel, mBuilder, isSecondaryChannelCtrl=False):
        super(BattleLayout, self).__init__()
        self._channel = channel
        self._view = None
        self._mBuilder = mBuilder
        self._isSecondaryChannelCtrl = isSecondaryChannelCtrl
        return

    def __del__(self):
        LOG_DEBUG('Channel controller deleted:', self)

    def getChannel(self):
        return self._channel

    def getSettings(self):
        raise NotImplementedError

    def getHistory(self):
        if self._channel:
            return self._channel.getHistory()
        return []

    def isEnabled(self):
        return isBattleChatEnabled()

    def clear(self):
        self.removeView()
        self._channel = None
        self._mBuilder = None
        return

    def setView(self, view):
        if self._view:
            LOG_ERROR('View is defined', self._view)
        elif isinstance(view, IBattleChannelView):
            self._view = view
            self._view.addController(self)
        else:
            LOG_ERROR('View must be IBattleChannelView', self._view)

    def removeView(self):
        if self._view is not None:
            self._view.removeController(self)
            self._view = None
        return

    def sendMessage(self, message):
        result, errorMsg = self.canSendMessage()
        if result:
            self._broadcast(message)
        elif self._view is not None:
            self._view.addMessage(g_settings.htmlTemplates.format('battleErrorMessage', ctx={'error': errorMsg}))
        return result

    def addMessage(self, message, doFormatting=True):
        isCurrent, text = self._formatMessage(message, doFormatting)
        if not self._isSecondaryChannelCtrl:
            self._channel.addMessage(text)
        if BattleReplay.g_replayCtrl.isRecording:
            BattleReplay.g_replayCtrl.onBattleChatMessage(text, isCurrent)
        if self._view:
            if isCurrent:
                fillColor = FILL_COLORS.BROWN
            else:
                fillColor = FILL_COLORS.BLACK
            self._view.addMessage(text, fillColor=fillColor, avatarSessionID=message.avatarSessionID)
        return True

    def addCommand(self, command):
        if command.hasNoChatMessage():
            return
        isCurrent, text = self._formatCommand(command)
        if self._view:
            if isCurrent:
                fillColor = FILL_COLORS.BROWN
            else:
                fillColor = FILL_COLORS.BLACK
            self._view.addMessage(text, fillColor=fillColor, avatarSessionID=command.getSenderID())

    def _broadcast(self, message):
        raise NotImplementedError

    def _formatMessage(self, message, doFormatting=True):
        raise NotImplementedError

    def _formatCommand(self, command):
        raise NotImplementedError