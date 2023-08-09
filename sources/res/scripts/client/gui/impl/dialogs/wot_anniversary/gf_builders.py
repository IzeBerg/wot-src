from gui.impl.dialogs.dialog_template_button import ConfirmButton
from gui.impl.dialogs.gf_builders import BaseDialogBuilder
from gui.impl.dialogs.sub_views.icon.icon_set import IconSet
from gui.impl.gen import R
from gui.impl.gen.view_models.views.dialogs.default_dialog_place_holders import DefaultDialogPlaceHolders
from gui.impl.gen.view_models.views.dialogs.sub_views.icon_set_view_model import IconPositionLogicEnum
from gui.impl.gen_utils import INVALID_RES_ID
from gui.impl.pub.dialog_window import DialogButtons

class WotAnniversaryDialogBuilder(BaseDialogBuilder):
    _ANNIVERSARY_LAYOUT_ID = R.views.lobby.wot_anniversary.WotAnniversaryDialog()

    def __init__(self, uniqueID=None):
        super(WotAnniversaryDialogBuilder, self).__init__(uniqueID)
        self.addButton(ConfirmButton(label=R.strings.wot_anniversary.interestingFactOverlayBtn.label()))
        self.setFocusedButtonID(DialogButtons.SUBMIT)
        self.__image = None
        self.setLayoutID(self._ANNIVERSARY_LAYOUT_ID)
        return

    def setImage(self, image, layoutID=None, iconPositionLogic=IconPositionLogicEnum.MOVECONTENTBELOW.value):
        self.__image = {'iconResID': INVALID_RES_ID, 
           'imageUrl': image, 
           'layoutID': layoutID, 
           'iconPositionLogic': iconPositionLogic}

    def _extendTemplate(self, template):
        super(WotAnniversaryDialogBuilder, self)._extendTemplate(template)
        if self.__image:
            template.setSubView(DefaultDialogPlaceHolders.ICON, IconSet(**self.__image))