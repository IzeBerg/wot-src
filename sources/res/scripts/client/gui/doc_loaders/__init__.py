from items import _xml

def readDict(xmlCtx, section, subsectionName, converter=lambda v: v.asString):
    result = {}
    for name, value in _xml.getChildren(xmlCtx, section, subsectionName):
        result[name] = converter(value)

    return result