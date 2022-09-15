import logging
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.battle.battle_page.full_stats.personal_reserves_tab_view import PersonalReservesTabView
_logger = logging.getLogger(__name__)

class PersonalReservesTab(InjectComponentAdaptor):

    def __init__(self):
        super(PersonalReservesTab, self).__init__()
        _logger.debug('[Personal Reserves Tab] init')

    def _onPopulate(self):
        _logger.debug('[Personal Reserves Tab] onPopulate')
        self._createInjectView()

    def _makeInjectView(self):
        _logger.debug('[Personal Reserves Tab] makeInjectView')
        return PersonalReservesTabView()