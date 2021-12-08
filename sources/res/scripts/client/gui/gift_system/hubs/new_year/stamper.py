import logging
from gui.gift_system.constants import NY_STAMP_CODE
from gui.gift_system.hubs.base.stamper import GiftEventBaseStamper
_logger = logging.getLogger(__name__)

class GiftEventNYStamper(GiftEventBaseStamper):
    __slots__ = ()
    _STAMPS = {
     NY_STAMP_CODE}