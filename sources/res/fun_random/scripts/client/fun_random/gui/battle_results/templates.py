from gui.battle_results.templates import regular
from fun_random.gui.battle_results import components
FUN_RANDOM_COMMON_STATS_BLOCK = regular.REGULAR_COMMON_STATS_BLOCK.clone(3)
FUN_RANDOM_COMMON_STATS_BLOCK.addComponent(3, components.FunRandomArenaFullNameItem('arenaStr'))