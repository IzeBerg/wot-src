import BigWorld, CGF
from cgf_script.managers_registrator import autoregister
from constants import IS_CLIENT
if IS_CLIENT:
    from Avatar import PlayerAvatar
    from ClientArena import ClientArena

def bonusCapsManager(bonusCap, domain=CGF.DomainOption.DomainAll):

    def predicate(spaceID):
        player = BigWorld.player()
        if spaceID != ClientArena.DEFAULT_ARENA_WORLD_ID and isinstance(player, PlayerAvatar):
            return player.hasBonusCap(bonusCap)
        return False

    return autoregister(presentInAllWorlds=True, creationPredicate=predicate, domain=domain)