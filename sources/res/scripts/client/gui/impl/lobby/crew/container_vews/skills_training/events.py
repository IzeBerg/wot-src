from gui.impl.lobby.container_views.base.events import ComponentEventsBase

class SkillsTrainingComponentViewEvents(ComponentEventsBase):

    def __init__(self):
        super(SkillsTrainingComponentViewEvents, self).__init__()
        self.onSkillHover = self._createEvent()
        self.onSkillOut = self._createEvent()
        self.onSkillClick = self._createEvent()
        self.onTrain = self._createEvent()
        self.onCancel = self._createEvent()
        self.onClose = self._createEvent()