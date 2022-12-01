import pkgutil
from ExtensionsManager import g_extensionsManager
from battle_modifiers import BattleParams, ModifiersContext, EXT_DATA_MODIFIERS_KEY
if 'battle_modifiers' in [ ext.name for ext in g_extensionsManager.activeExtensions ] and pkgutil.find_loader('battle_modifiers_ext'):
    from battle_modifiers_ext.battle_modifiers import BattleModifiers, getGlobalModifiers
    from battle_modifiers_ext import getModificationCache
else:
    from battle_modifiers import BattleModifiers, getGlobalModifiers, getModificationCache
__all__ = ('EXT_DATA_MODIFIERS_KEY', 'BattleParams', 'BattleModifiers', 'ModifiersContext',
           'getGlobalModifiers', 'getModificationCache')