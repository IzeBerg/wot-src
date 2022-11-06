from gui.Scaleform.daapi.view.lobby.hangar.Crew import Crew

class BCCrew(Crew):

    def __init__(self, ctx=None):
        super(BCCrew, self).__init__()
        self._showRecruit = False

    def onShowRecruitWindowClick(self, _, __):
        pass