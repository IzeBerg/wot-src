from web.web_client_api import w2capi
from web.web_client_api.request.access_token import AccessTokenWebApiMixin
from web.web_client_api.request.graphics_settings import GraphicsSettingsWebApiMixin
from web.web_client_api.request.settings import SettingsWebApiMixin
from web.web_client_api.request.spa_id import SpaIdWebApiMixin
from web.web_client_api.request.wgni_token import WgniTokenWebApiMixin

@w2capi('request', 'request_id')
class RequestWebApi(AccessTokenWebApiMixin, GraphicsSettingsWebApiMixin, SettingsWebApiMixin, SpaIdWebApiMixin, WgniTokenWebApiMixin):
    pass