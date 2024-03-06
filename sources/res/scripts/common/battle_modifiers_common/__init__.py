import pkgutil
from ExtensionsManager import g_extensionsManager
from battle_modifiers import BattleParams, ModifiersContext, ConstantsSet, EXT_DATA_MODIFIERS_KEY, BATTLE_MODIFIERS_TYPE
if 'battle_modifiers' in [ ext.name for ext in g_extensionsManager.activeExtensions ] and pkgutil.find_loader('battle_modifiers_ext'):
    from battle_modifiers_ext.battle_modifiers import BattleModifiers, getGlobalModifiers
else:
    from battle_modifiers import BattleModifiers, getGlobalModifiers
__all__ = ('EXT_DATA_MODIFIERS_KEY', 'BATTLE_MODIFIERS_TYPE', 'BattleParams', 'BattleModifiers',
           'ModifiersContext', 'getGlobalModifiers')