import WWISE
from gui.impl.dialogs.dialog_template_button import ConfirmButton, CancelButton
from gui.impl.dialogs.gf_builders import BaseDialogBuilder
from gui.impl.gen import R
from gui.impl.gen.view_models.views.dialogs.default_dialog_place_holders import DefaultDialogPlaceHolders
from gui.impl.gen.view_models.views.dialogs.dialog_template_button_view_model import ButtonType
from gui.impl.gen.view_models.views.dialogs.template_settings.default_dialog_template_settings import DisplayFlags
from gui.impl.pub.dialog_window import DialogButtons
from halloween.gui.impl.lobby.dialogs.sub_views.footer.hw_single_price import HWSinglePrice
from halloween.gui.sounds.sound_constants import ArtefactDialogState

class BaseArtefactDialogBuilder(BaseDialogBuilder):
    __slots__ = ('_price', )

    def __init__(self, price, uniqueID=None):
        super(BaseArtefactDialogBuilder, self).__init__(uniqueID=uniqueID)
        self._price = price
        self.setIcon(R.images.halloween.gui.maps.icons.meta.key_films_180x135())
        self.setDisplayFlags(DisplayFlags.DISABLERESPONSIVECONTENTPOSITION.value)
        self.setFocusedButtonID(DialogButtons.SUBMIT)
        WWISE.WW_setState(ArtefactDialogState.GROUP, ArtefactDialogState.UI_VISIBLE)

    def _extendTemplate(self, template):
        super(BaseArtefactDialogBuilder, self)._extendTemplate(template)
        template.setSubView(DefaultDialogPlaceHolders.FOOTER, HWSinglePrice(R.strings.dialogs.common.cost, self._price))


class OpenArtefactDialogBuilder(BaseArtefactDialogBuilder):

    def __init__(self, price, uniqueID=None):
        super(OpenArtefactDialogBuilder, self).__init__(price=price, uniqueID=uniqueID)
        self.setTitle(R.strings.halloween_lobby.openArtefact.confirmation.title())
        self.addButton(ConfirmButton(label=R.strings.halloween_lobby.openArtefact.confirmation.accept(), buttonType=ButtonType.PRIMARY))
        self.addButton(CancelButton(label=R.strings.halloween_lobby.openArtefact.confirmation.cancel()))


class SkipArtefactDialogBuilder(BaseArtefactDialogBuilder):

    def __init__(self, price, uniqueID=None):
        super(SkipArtefactDialogBuilder, self).__init__(price=price, uniqueID=uniqueID)
        self.setTitle(R.strings.halloween_lobby.skipArtefact.confirmation.title())
        self.setDescription(R.strings.halloween_lobby.skipArtefact.confirmation.body())
        self.addButton(ConfirmButton(label=R.strings.halloween_lobby.skipArtefact.confirmation.accept(), buttonType=ButtonType.PRIMARY))
        self.addButton(CancelButton(label=R.strings.halloween_lobby.skipArtefact.confirmation.cancel()))