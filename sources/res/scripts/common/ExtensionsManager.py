import BigWorld, os, ResMgr
from collections import namedtuple
Extension = namedtuple('Extension', ('path', 'name', 'isEnabled'))

class ExtensionsManager(object):

    def __init__(self):
        self.__extensions = {}
        for root, dirs, files in os.walk('../wot_ext'):
            if 'extension.xml' in files:
                extension = self.__readExtension(root)
                self.__extensions[extension.name] = extension

    def __readExtension(self, root):
        section = ResMgr.openSection(root + '/extension.xml')
        return Extension(root + '/', section.readString('FeatureName'), section.readBool('IsEnabled'))

    @property
    def extensions(self):
        return self.__extensions.values()


g_extensionsManager = ExtensionsManager()