from web.web_client_api import w2capi
from web.web_client_api.hero_tank.vehicle import HeroTankWebApiMixin

@w2capi(name='hero_tank', key='action')
class HeroTankWebApi(HeroTankWebApiMixin):
    pass