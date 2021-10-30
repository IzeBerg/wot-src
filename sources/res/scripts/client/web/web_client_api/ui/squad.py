from gui.prb_control import prbDispatcherProperty
from gui.prb_control.entities.base.ctx import PrbAction
from gui.prb_control.settings import PREBATTLE_ACTION_NAME
from web.web_client_api import w2c, W2CSchema, Field
from web.web_client_api.common import SPA_ID_TYPES

class _CreateSquadSchema(W2CSchema):
    spa_id = Field(required=True, type=SPA_ID_TYPES)


class SquadWebApiMixin(object):

    @prbDispatcherProperty
    def prbDispatcher(self):
        return

    @w2c(_CreateSquadSchema, 'squad_window')
    def createSquad(self, usersIds):
        yield self.prbDispatcher.doSelectAction(PrbAction(PREBATTLE_ACTION_NAME.SQUAD, accountsToInvite=(usersIds.spa_id,)))