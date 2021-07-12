from tutorial.control import context, game_vars
from tutorial.control.lobby.context import LobbyBonusesRequester

class ChainsStartReqs(context.StartReqs):

    def prepare(self, ctx):
        ctx.bonusCompleted = game_vars.getTutorialsCompleted()

    def process(self, descriptor, ctx):
        return True


class ChainsBonusesRequester(LobbyBonusesRequester):
    pass