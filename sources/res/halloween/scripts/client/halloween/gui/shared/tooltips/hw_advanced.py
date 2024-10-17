from gui.shared.tooltips.advanced import MODULE_MOVIES
from gui.Scaleform.daapi.settings.config import ADVANCED_COMPLEX_TOOLTIPS
from halloween.gui.impl.lobby.tank_setup.backports.tooltips import HW_CONSUMABLE_EMPTY_TOOLTIP

def registerHWEquipmentTooltipMovies():
    MODULE_MOVIES.update({'hw_hpRepairAndCrewHeal': 'halloween|hw_hpRepairAndCrewHeal', 
       'hw_teamRepairKit': 'halloween|hw_teamRepairKit', 
       'hw_damageShield': 'halloween|hw_damageShield', 
       'hw_fastReload': 'halloween|hw_fastReload', 
       'hw_invisibility': 'halloween|hw_invisibility', 
       'hw_aoeDamageInstantShot': 'halloween|hw_aoeDamageInstantShot', 
       'hw_aoeStunInstantShot': 'halloween|hw_aoeStunInstantShot', 
       'hw_aoeDrainEnemyHpInstantShot': 'halloween|hw_aoeDrainEnemyHpInstantShot'})
    ADVANCED_COMPLEX_TOOLTIPS.update({HW_CONSUMABLE_EMPTY_TOOLTIP: 'halloween|hw_equipment'})