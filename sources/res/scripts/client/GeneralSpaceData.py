import BigWorld

class GeneralSpaceData(BigWorld.Space):

    def set_environment(self, prev):
        name = self.environment
        if name:
            self.setEnvironment(name)
        else:
            self.resetEnvironment()