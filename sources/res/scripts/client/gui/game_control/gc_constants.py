from shared_utils import CONST_CONTAINER

class BROWSER(CONST_CONTAINER):
    SIZE = (990, 550)
    VIDEO_SIZE = (864, 486)


class PROMO(CONST_CONTAINER):

    class TEMPLATE(CONST_CONTAINER):
        PATCH = 'promo_patchnote'
        ACTION = 'promo_action'