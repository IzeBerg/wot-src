from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class SkillUntrainedAdditionalTooltip(ViewImpl):

    def __init__(self):
        settings = ViewSettings(R.views.lobby.crew.tooltips.SkillUntrainedAdditionalTooltip(), model=ViewModel())
        super(SkillUntrainedAdditionalTooltip, self).__init__(settings)