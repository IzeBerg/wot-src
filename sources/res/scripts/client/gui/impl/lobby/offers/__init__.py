import typing
from constants import GF_RES_PROTOCOL
from gui.shared.utils.functions import getAbsoluteUrl

def getGfImagePath(imgPath):
    if imgPath is None:
        return
    else:
        newPath = getAbsoluteUrl(imgPath)
        newPath = newPath.replace('\\', '/')
        if not newPath.startswith(GF_RES_PROTOCOL.IMG):
            newPath = ('').join([GF_RES_PROTOCOL.IMG, newPath])
        return newPath