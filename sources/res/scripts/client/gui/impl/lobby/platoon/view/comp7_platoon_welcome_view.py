import logging
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.platoon.platoon_dropdown_model import Type
from gui.impl.lobby.platoon.view.platoon_welcome_view import WelcomeView
from gui.impl.lobby.premacc.squad_bonus_tooltip_content import Comp7SquadBonusTooltipContent
from gui.prb_control.entities.comp7 import comp7_prb_helpers
from gui.prb_control.settings import SELECTOR_BATTLE_TYPES
_logger = logging.getLogger(__name__)
strButtons = R.strings.platoon.buttons

class Comp7WelcomeView(WelcomeView):
    _squadType = Type.COMP7

    def _initButtons(self):
        with self.viewModel.transaction() as (model):
            model.btnCreateForTwo.setText(backport.text(strButtons.createPlatoon.comp7.forTwo.text()))
            model.btnCreateForTwo.setCaption(backport.text(strButtons.createPlatoon.caption()))
            model.btnCreateForTwo.setTooltipCaption(backport.text(strButtons.createPlatoon.comp7.forTwo.caption()))
            model.btnCreateForTwo.setDescription(backport.text(strButtons.createPlatoon.comp7.forTwo.description()))
            model.btnCreateForSeven.setText(backport.text(strButtons.createPlatoon.comp7.forSeven.text()))
            model.btnCreateForSeven.setCaption(backport.text(strButtons.createSuperPlatoon.caption()))
            model.btnCreateForSeven.setTooltipCaption(backport.text(strButtons.createPlatoon.comp7.forSeven.caption()))
            model.btnCreateForSeven.setDescription(backport.text(strButtons.createPlatoon.comp7.forSeven.description()))

    def _addListeners(self):
        with self.viewModel.transaction() as (model):
            model.btnCreateForTwo.onClick += self.__onCreateForTwo
            model.btnCreateForSeven.onClick += self.__onCreateForSeven
            model.onOutsideClick += self._onOutsideClick

    def _removeListeners(self):
        with self.viewModel.transaction() as (model):
            model.btnCreateForTwo.onClick -= self.__onCreateForTwo
            model.btnCreateForSeven.onClick -= self.__onCreateForSeven
            model.onOutsideClick += self._onOutsideClick

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.lobby.premacc.squad_bonus_tooltip_content.SquadBonusTooltipContent():
            return Comp7SquadBonusTooltipContent(SELECTOR_BATTLE_TYPES.COMP7)
        return super(Comp7WelcomeView, self).createToolTipContent(event=event, contentID=contentID)

    @staticmethod
    def __onCreateForTwo():
        comp7_prb_helpers.createComp7Squad(squadSize=2)

    @staticmethod
    def __onCreateForSeven():
        comp7_prb_helpers.createComp7Squad(squadSize=7)