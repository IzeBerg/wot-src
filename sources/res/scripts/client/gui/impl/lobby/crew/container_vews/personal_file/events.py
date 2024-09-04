from gui.impl.lobby.crew.container_vews.common.base_personal_case_events import BasePersonalCaseComponentViewEvents

class PersonalFileComponentViewEvents(BasePersonalCaseComponentViewEvents):

    def __init__(self):
        super(PersonalFileComponentViewEvents, self).__init__()
        self.onIncreaseClick = self._createEvent()
        self.onSkillClick = self._createEvent()
        self.onSetAnimationInProgress = self._createEvent()
        self.onResetClick = self._createEvent()
        self.onWidgetClick = self._createEvent()