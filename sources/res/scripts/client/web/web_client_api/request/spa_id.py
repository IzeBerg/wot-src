from helpers import dependency
from skeletons.connection_mgr import IConnectionManager
from web.web_client_api import w2c, W2CSchema

class SpaIdWebApiMixin(object):
    connectionMgr = dependency.descriptor(IConnectionManager)

    @w2c(W2CSchema, 'spa_id')
    def spaId(self, cmd):
        if self.connectionMgr is not None:
            yield {'spa_id': str(self.connectionMgr.databaseID)}
        else:
            yield {'error': 'Unable to obtain spa id'}
        return