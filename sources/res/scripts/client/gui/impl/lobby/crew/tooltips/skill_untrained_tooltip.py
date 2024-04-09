from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class SkillUntrainedTooltip(ViewImpl):

    def __init__(self):
        settings = ViewSettings(R.views.lobby.crew.tooltips.SkillUntrainedTooltip(), model=ViewModel())
        super(SkillUntrainedTooltip, self).__init__(settings)