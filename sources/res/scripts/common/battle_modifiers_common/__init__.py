import pkgutil
from ExtensionsManager import g_extensionsManager
from battle_modifiers import BattleParams, EXT_DATA_MODIFIERS_KEY
if 'battle_modifiers' in [ ext.name for ext in g_extensionsManager.activeExtensions ] and pkgutil.find_loader('battle_modifiers_ext'):
    from battle_modifiers_ext.battle_modifiers import BattleModifiers
    from battle_modifiers_ext import getGlobalModifiers, getModificationCache
else:
    from battle_modifiers import BattleModifiers, getGlobalModifiers, getModificationCache
__all__ = ('EXT_DATA_MODIFIERS_KEY', 'BattleParams', 'BattleModifiers', 'getGlobalModifiers',
           'getModificationCache')