from tutorial.data.has_id import HasID

class Checkpoint(HasID):

    def __init__(self, entityID, conditions, effects):
        super(Checkpoint, self).__init__(entityID=entityID)
        self.__conditions = conditions
        self.__effects = effects

    def getConditions(self):
        return self.__conditions

    def getEffects(self):
        return self.__effects[:]