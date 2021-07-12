from helpers import aop

class IsPersonalMissionsEnabled(aop.Aspect):

    def atReturn(self, cd):
        cd.change()
        return False