import importlib
from ExtensionsManager import g_extensionsManager
from constants import IS_CLIENT, IS_EDITOR
from debug_utils import LOG_CURRENT_EXCEPTION
from extension_rules import isExtXML, READ_METHOD
if IS_CLIENT or IS_EDITOR:
    import ResMgr as rmgr
else:
    from realm_utils import ResMgr as rmgr
    from realm_utils import getRealmFilePath
_ROOT_TAG = 'root'
_XML_NAMESPACE = ' xmlns:xmlref="http://bwt/xmlref"'
_MERGE_TAG = 'xmlref:merge'
_CONTENT_TAG = 'xmlref:content'
_INCLUDE_TAG = 'xmlref:include'

def importClass(classPath, defaultMod):
    modPath, _, className = classPath.rpartition('.')
    try:
        mod = importlib.import_module(modPath or defaultMod)
    except ImportError:
        LOG_CURRENT_EXCEPTION()
        return

    return getattr(mod, className, None)


class _MergeExtensionFile(object):

    @classmethod
    def openSection(cls, xmlPath, mergeFiles):
        if not IS_EDITOR:
            extensions = g_extensionsManager.activeExtensions if 1 else g_extensionsManager.extensions
            xmlPaths = [ ext.path + xmlPath for ext in extensions if rmgr.isFile(ext.path + xmlPath)
                       ]
            if not xmlPaths:
                return rmgr.openSection(xmlPath)
            genString = cls._openTag(('{} {}').format(_ROOT_TAG, _XML_NAMESPACE))
            if mergeFiles:
                genString += cls._openTag(_MERGE_TAG)
            if rmgr.isFile(xmlPath):
                xmlPaths = [
                 xmlPath] + xmlPaths
            xmlPaths = IS_CLIENT or IS_EDITOR or [ getRealmFilePath(xmlPath) if rmgr.isFile(getRealmFilePath(xmlPath)) else xmlPath for xmlPath in xmlPaths
                                                 ]
        for path in xmlPaths:
            if mergeFiles:
                genString += cls._openTag(_CONTENT_TAG)
            genString += cls._attributeTag(_INCLUDE_TAG, 'href', path)
            if mergeFiles:
                genString += cls._closeTag(_CONTENT_TAG)

        if mergeFiles:
            genString += cls._closeTag(_MERGE_TAG)
        genString += cls._closeTag(_ROOT_TAG)
        section = rmgr.DataSection()
        section.createSectionFromString(genString)
        if section.child(0).name == 'root':
            section = section.child(0)
        return section

    @classmethod
    def _openTag(cls, tag):
        return '<' + tag + '>\n'

    @classmethod
    def _closeTag(cls, tag):
        return '</' + tag + '>\n'

    @classmethod
    def _attributeTag(cls, tag, attrName, attrValue):
        return ('<{} {}="{}"/>\n').format(tag, attrName, attrValue)


class ResMgr(object):

    class __metaclass__(type):

        def __getattr__(self, item):
            if IS_CLIENT:
                return getattr(rmgr, item)
            return getattr(self if item in ('openSection', ) else rmgr, item)

    @staticmethod
    def openSection(filepath, createIfMissing=False):
        readExtXML, readMethod = isExtXML(filepath)
        if not readExtXML:
            return rmgr.openSection(filepath, createIfMissing)
        return _MergeExtensionFile.openSection(filepath, readMethod == READ_METHOD.MERGE)