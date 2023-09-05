import BigWorld

def runPlan(entity, planName, params, key='', contextName=''):
    player = BigWorld.player()
    if player is not None:
        arena = player.arena
        if arena is not None:
            context = None
            if contextName:
                if entity and hasattr(entity, 'getVseContextInstance'):
                    context = entity.getVseContextInstance(contextName)
                else:
                    context = arena.getVseContextInstance(contextName)
            arena.runVsePlan(planName, params, key, context)
    return


def stopPlan(planName, key=''):
    player = BigWorld.player()
    if player is not None:
        arena = player.arena
        if arena is not None:
            arena.stopVsePlan(planName, key)
    return