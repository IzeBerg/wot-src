import aspects
from helpers import aop

class ShowBGWallpaper(aop.Pointcut):

    def __init__(self):
        aop.Pointcut.__init__(self, 'gui.Scaleform.daapi.view.login.login_modes.view_background', 'ViewBackground', 'show$', aspects=(
         aspects.ShowBGWallpaper,))