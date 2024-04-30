from frameworks.wulf import ViewSettings
from gui.impl.dialogs.dialog_template_utils import toString
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.historical_battles.dialogs.content.text_with_warning_view_model import TextWithWarningViewModel
from gui.impl.pub import ViewImpl

class TextWithWarning(ViewImpl):
    __slots__ = ()

    def __init__(self, mainText, warningText=None, warningImageSubstitution=None):
        settings = ViewSettings(R.views.lobby.historical_battles.dialogs.sub_views.content.TextWithWarning())
        settings.model = TextWithWarningViewModel()
        settings.kwargs = {'mainText': mainText, 
           'warningText': warningText, 
           'warningImageSubstitution': warningImageSubstitution}
        super(TextWithWarning, self).__init__(settings)

    def _onLoading(self, mainText, warningText, warningImageSubstitution, *args, **kwargs):
        super(TextWithWarning, self)._onLoading(*args, **kwargs)
        with self.getViewModel().transaction() as (model):
            model.setMainText(toString(mainText))
            if warningText:
                model.setWarningText(toString(warningText))
            imageSubs = model.warningImageSubstitution
            imageSubs.setPath(warningImageSubstitution.resourceID)
            imageSubs.setPlaceholder(warningImageSubstitution.placeholder)
            imageSubs.setMarginTop(warningImageSubstitution.marginTop)
            imageSubs.setMarginRight(warningImageSubstitution.marginRight)
            imageSubs.setMarginBottom(warningImageSubstitution.marginBottom)
            imageSubs.setMarginLeft(warningImageSubstitution.marginLeft)