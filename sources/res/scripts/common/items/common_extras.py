from extension_utils import importClass
from items import _xml
from constants import IS_CLIENT, IS_EDITOR, IS_BOT
import collections

def readExtras(xmlCtx, section, subsectionName, defaultModName, **kwargs):
    NoneExtra = importClass('NoneExtra', defaultModName)
    noneExtra = NoneExtra('_NoneExtra', 0, '', None)
    extras = [
     noneExtra]
    extrasDict = {noneExtra.name: noneExtra}
    for extraName, extraSection in _xml.getChildren(xmlCtx, section, subsectionName):
        ctx = (xmlCtx, subsectionName + '/' + extraName)
        if extrasDict.has_key(extraName):
            _xml.raiseWrongXml(ctx, '', 'name is not unique')
        clientName, _, serverName = extraSection.asString.partition(':')
        classPath = (clientName if IS_CLIENT or IS_EDITOR or IS_BOT else serverName).strip()
        classObj = importClass(classPath, defaultModName)
        if classObj is not None:
            classExtras = classObj(extraName, len(extras), xmlCtx[1], extraSection, **kwargs)
            if isinstance(classExtras, collections.Iterable):
                for extra in classExtras:
                    extrasDict[extra.name] = extra

                extras.extend(classExtras)
            else:
                extras.append(classExtras)
                extrasDict[extraName] = classExtras
        else:
            _xml.raiseWrongXml(ctx, '', "Can't import %s" % classPath)

    if len(extras) > 200:
        _xml.raiseWrongXml(xmlCtx, subsectionName, 'too many extras')
    return (tuple(extras), extrasDict)