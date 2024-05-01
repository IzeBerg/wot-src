import random
from typing import TYPE_CHECKING
from cosmic_account_settings import PRB_HINT_NUM, getSettings, setSettings
from gui import makeHtmlString
from gui.impl import backport
if TYPE_CHECKING:
    from gui.impl.gen_utils import DynAccessor

def _createHtmlTextWithDescr(title, descrTxt):
    return makeHtmlString('html_templates:battle/loadingScreenSimple', 'mainTip', ctx={'title': backport.text(title), 
       'description': backport.text(descrTxt)})


def _makePath(itemIndex):
    return ('cosmic_event/gui/maps/icons/map/screen/prebattle_hints/hint_{}.dds').format(itemIndex)


class PrbRandomHintManager(object):

    def __init__(self, texts, images):
        super(PrbRandomHintManager, self).__init__()
        self._imgAndText = []
        totalHintCount = max(texts.length(), images.length())
        foundTexts = []
        foundImgs = []
        for i in range(totalHintCount):
            itemIndex = i + 1
            txtItem = texts.dyn(('hint{}').format(itemIndex))
            if txtItem:
                foundTexts.append(txtItem)
            imgRPath = images.dyn(('hint_{}').format(itemIndex))
            imgStrPath = None
            if imgRPath:
                imgStrPath = _makePath(itemIndex)
                foundImgs.append(imgStrPath)
            self._imgAndText.append((
             imgStrPath,
             _createHtmlTextWithDescr(txtItem.title(), txtItem.description()) if txtItem else None))

        random.shuffle(foundImgs)
        random.shuffle(foundTexts)
        for i, (img, txt) in enumerate(self._imgAndText):
            if img is None:
                if len(foundImgs) > 1:
                    self._imgAndText[i] = (
                     foundImgs.pop(), txt)
                else:
                    self._imgAndText[i] = (
                     foundImgs[0], txt)
            if txt is None:
                imgRef = self._imgAndText[i][0]
                if len(foundTexts) > 1:
                    self._imgAndText[i] = (
                     imgRef, foundTexts.pop())
                elif len(foundTexts) == 1:
                    self._imgAndText[i] = (
                     imgRef, foundTexts[0])
                else:
                    self._imgAndText[i] = (
                     imgRef, '')

        self._imgAndText = tuple(self._imgAndText)
        return

    def incrementAndSave(self):
        currHintNum = getSettings(PRB_HINT_NUM)
        setSettings(PRB_HINT_NUM, (currHintNum + 1) % len(self._imgAndText))

    def getHintText(self):
        return self._imgAndText[getSettings(PRB_HINT_NUM)][1]

    def getHintImagePath(self):
        return self._imgAndText[getSettings(PRB_HINT_NUM)][0]