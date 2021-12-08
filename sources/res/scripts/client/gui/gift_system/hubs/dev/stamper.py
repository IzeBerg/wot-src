import logging
from gui.gift_system.constants import DEV_STAMP_CODE
from gui.gift_system.hubs.base.stamper import GiftEventBaseStamper
_logger = logging.getLogger(__name__)

class GiftEventDevStamper(GiftEventBaseStamper):
    __slots__ = ()
    _STAMPS = {
     DEV_STAMP_CODE}