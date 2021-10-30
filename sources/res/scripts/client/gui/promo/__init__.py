from skeletons.gui.shared.promo import IPromoLogger
__all__ = ('getPromoConfig', )

def getPromoConfig(manager):
    from gui.promo.promo_logger import PromoLogger
    logger = PromoLogger()
    manager.addInstance(IPromoLogger, logger, finalizer='fini')