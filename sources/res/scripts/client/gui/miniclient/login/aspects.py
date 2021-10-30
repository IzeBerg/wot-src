from helpers import aop

class ShowBGWallpaper(aop.Aspect):

    def atCall(self, cd):
        super(ShowBGWallpaper, self).atCall(cd)
        cd.self.showWallpaper(showSwitchButton=False)
        cd.avoid()