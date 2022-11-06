

class CustomActionsKeeper(object):
    __actions = {}

    @classmethod
    def registerAction(cls, actionId, actionHandler):
        cls.__actions[actionId] = actionHandler

    @classmethod
    def getAction(cls, actionId):
        return cls.__actions.get(actionId, None)

    @classmethod
    def invoke(cls, actor, **kwargs):
        if actor is None:
            return
        else:
            if hasattr(actor, 'invoke'):
                actor.invoke(**kwargs)
            else:
                actor(**kwargs)
            return