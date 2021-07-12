from helpers import aop
import aspects

class MakeStrongholdsUnavailable(aop.Pointcut):

    def __init__(self):
        aop.Pointcut.__init__(self, 'gui.Scaleform.daapi.view.lobby.header.LobbyHeader', 'LobbyHeader', '_updateStrongholdsSelector', aspects=(
         aspects.MakeStrongholdsUnavailable(),))