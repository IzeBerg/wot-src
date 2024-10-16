from collections import namedtuple
from operator import getitem
import resource_helper
from debug_utils import LOG_ERROR
from gui.Scaleform.genConsts.TWEEN_EFFECT_TYPES import TWEEN_EFFECT_TYPES
__all__ = ('readConfig', 'clearConfig')
_cache = {}

def readConfig(path, forced=False):
    global _cache
    if not forced and path in _cache:
        return _cache[path]
    else:
        scenes, items, commands = (None, None, None)
        with resource_helper.root_generator(path) as (ctx, root):
            scenes = _readConfig(ctx, root, 'scenes', 'scene', _SceneConfig)
            items = _readConfig(ctx, root, 'gui-items', 'item', _ItemConfig)
            commands = _readConfig(ctx, root, 'gui-commands', 'command', _CommandData)
        _cache[path] = _TutorialConfig(scenes, items, commands)
        return _cache[path]


def clearConfig(path):
    if path in _cache:
        del _cache[path]


def _getEnumValueByName(name, enum):
    if isinstance(enum, dict):
        valGetter = getitem
        invalidFlagExceptionType = KeyError
    else:
        valGetter = getattr
        invalidFlagExceptionType = AttributeError
    try:
        flagVal = valGetter(enum, name)
        return flagVal
    except invalidFlagExceptionType:
        LOG_ERROR('name not found in enum:', name, enum)
        return name


def _listToBitmask(flagNamesList, flagsEnum):
    mask = 0
    for flagName in flagNamesList:
        flagVal = _getEnumValueByName(flagName, flagsEnum)
        try:
            mask |= _getEnumValueByName(flagName, flagsEnum)
        except TypeError:
            LOG_ERROR('invalid flag value (expecting integer):', flagName, flagVal)

    return mask


class _ItemConfig(object):
    __slots__ = ('__view', '__path', '__padding', '__anim', '__effectBuilders')

    def __init__(self, view='', path='', padding=None, anim=None, effectBuilders=None):
        self.__view = view
        self.__path = path
        self.__padding = self._defaultPadding()
        self.__anim = self._defaultAnimConfig()
        self.__effectBuilders = effectBuilders.copy() if effectBuilders is not None else {}
        if padding is not None:
            self.__padding.update(padding)
        if anim is not None:
            if 'tween' in anim and 'flags' in anim['tween']:
                anim['tween']['flags'] = _listToBitmask(anim['tween']['flags'], TWEEN_EFFECT_TYPES)
            self.__anim.update(anim)
        return

    @property
    def view(self):
        return self.__view

    @property
    def path(self):
        return self.__path

    @property
    def padding(self):
        return self.__padding

    @property
    def anim(self):
        return self.__anim

    @property
    def effectBuilders(self):
        return self.__effectBuilders

    @staticmethod
    def _defaultPadding():
        return {'left': 0, 
           'top': 0, 
           'right': 0, 
           'bottom': 0}

    @staticmethod
    def _defaultAnimConfig():
        return {'tween': {'flags': TWEEN_EFFECT_TYPES.ALPHA, 
                     'delay': 0}, 
           'clip': {'linkage': 'BCLobbySlotUI', 
                    'offsetX': 0, 
                    'offsetY': 0}, 
           'overlay': {'x': 0, 
                       'y': 0, 
                       'width': 100, 
                       'height': 100}}


_SceneConfig = namedtuple('_SceneConfig', ('sceneID', 'event'))
_CommandData = namedtuple('_CommandData', ('type', 'name', 'args'))

class _TutorialConfig(object):
    __slots__ = ('__scenes', '__guiItems', '__commands')

    def __init__(self, scenes=None, items=None, commands=None):
        super(_TutorialConfig, self).__init__()
        self.__scenes = scenes or {}
        self.__guiItems = items or {}
        self.__commands = commands or {}

    def isEmpty(self):
        return not self.__scenes and not self.__guiItems and not self.__commands

    def getSceneID(self, guiPage):
        try:
            return self.__scenes[guiPage].sceneID
        except KeyError:
            return ''

    def getSceneEvent(self, sceneID):
        scenes = dict((scene.sceneID, scene.event) for scene in self.__scenes.itervalues())
        try:
            return scenes[sceneID]
        except KeyError:
            return ''

    def getItem(self, targetID):
        if targetID in self.__guiItems:
            return self.__guiItems[targetID]
        else:
            return

    def getItems(self):
        for itemID, item in self.__guiItems.iteritems():
            yield (
             itemID, item)

    def getCommand(self, commandID):
        try:
            return self.__commands[commandID]
        except KeyError:
            return

        return

    def getCommands(self):
        for commandID, command in self.__commands.iteritems():
            yield (
             commandID, command)


_ITEM_TYPE = resource_helper.RESOURCE_ITEM_TYPE

def _readConfig(ctx, root, parentTag, childTag, itemClass):
    ctx, section = resource_helper.getSubSection(ctx, root, parentTag, safe=True)
    if not section:
        return {}
    config = {}
    for xmlCtx, subSection in resource_helper.getIterator(ctx, section):
        item = resource_helper.readItem(xmlCtx, subSection, childTag)
        name = item.name
        if name in config:
            raise resource_helper.ResourceError(xmlCtx, ('Item {0} is duplicated.').format(name))
        config[name] = itemClass(**item.value)

    return config