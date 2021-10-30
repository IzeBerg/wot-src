from helpers import dependency, time_utils
from skeletons.connection_mgr import IConnectionManager
from skeletons.gui.web import IWebController
from web.web_client_api import w2c, W2CSchema, Field

class _RequestAccessTokenSchema(W2CSchema):
    force = Field(required=False, type=bool)


class AccessTokenWebApiMixin(object):
    _connectionMgr = dependency.descriptor(IConnectionManager)
    _webCtrl = dependency.descriptor(IWebController)

    @w2c(_RequestAccessTokenSchema, 'access_token')
    def accessToken(self, cmd):
        accessTokenData = yield self._webCtrl.getAccessTokenData(force=cmd.force)
        if accessTokenData is not None:
            yield {'spa_id': str(self._connectionMgr.databaseID), 'access_token': str(accessTokenData.accessToken), 
               'expires_in': accessTokenData.expiresAt - time_utils.getCurrentTimestamp(), 
               'periphery_id': str(self._connectionMgr.peripheryID)}
        else:
            yield {'error': 'Unable to obtain access token.'}
        return