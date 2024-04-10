import string, ResMgr as rmgr
from constants import CURRENT_REALM, IS_CLIENT, IS_EDITOR, REALMS

def getRealmFilePath(filepath):
    parts = filepath.split('.')
    return string.join(parts[:-1] + [CURRENT_REALM] + parts[-1:], '.')


def isFileWithRealm(fileName):
    parts = fileName.split('.')
    return len(parts) > 2 and parts[(-2)] in REALMS


def isFileWithCurrentRealm(fileName):
    parts = fileName.split('.')
    return len(parts) > 2 and parts[(-2)] == CURRENT_REALM


class ResMgr(object):

    class __metaclass__(type):

        def __getattr__(self, item):
            if IS_CLIENT:
                return getattr(rmgr, item)
            return getattr(self if item in ('openSection', 'purge') else rmgr, item)

    @staticmethod
    def openSection(filepath, createIfMissing=False):
        section = (IS_EDITOR or rmgr.openSection)(getRealmFilePath(filepath)) if 1 else None
        if section is not None:
            return section
        else:
            return rmgr.openSection(filepath, createIfMissing)

    @staticmethod
    def purge(filepath, recursive=False):
        if not filepath:
            return
        rmgr.purge(filepath, recursive)
        rmgr.purge(getRealmFilePath(filepath), recursive)