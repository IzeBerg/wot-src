from gui.shared.tooltips.advanced import MODULE_MOVIES
from gui.Scaleform.daapi.settings.config import ADVANCED_COMPLEX_TOOLTIPS
from halloween.gui.impl.lobby.tank_setup.backports.tooltips import HW_CONSUMABLE_EMPTY_TOOLTIP

def registerHWEquipmentTooltipMovies():
    MODULE_MOVIES.update({'hw23_igniteEnemiesInRadius': 'hw23_igniteEnemiesInRadius', 
       'hw23_drainHpInRadius': 'hw23_drainHpInRadius', 
       'hw23_damageEnemiesInRadius': 'hw23_damageEnemiesInRadius', 
       'hw23_hpRepairAndCrewHeal': 'hw23_hpRepairAndCrewHeal', 
       'hw23_teamRepairKit': 'hw23_teamRepairKit', 
       'hw23_damageShield': 'hw23_damageShield', 
       'hw23_instantReload': 'hw23_instantReload', 
       'hw23_fastReload': 'hw23_fastReload', 
       'hw23_invisibility': 'hw23_invisibility'})
    ADVANCED_COMPLEX_TOOLTIPS.update({HW_CONSUMABLE_EMPTY_TOOLTIP: 'hw23_equipment'})