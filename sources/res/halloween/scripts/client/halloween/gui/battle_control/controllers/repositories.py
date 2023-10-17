from gui.battle_control.controllers import battle_field_ctrl, debug_ctrl, team_bases_ctrl, default_maps_ctrl, perk_ctrl, personal_death_zones_gui_ctrl
from gui.battle_control.controllers import battle_hints_ctrl
from gui.battle_control.controllers.repositories import ControllersRepositoryByBonuses
from halloween.gui.battle_control.controllers import appearance_cache_ctrl
from halloween.gui.battle_control.controllers import battle_gui_controller

class HalloweenControllerRepository(ControllersRepositoryByBonuses):
    __slots__ = ()

    @classmethod
    def create(cls, setup):
        repository = super(HalloweenControllerRepository, cls).create(setup)
        repository.addArenaViewController(team_bases_ctrl.createTeamsBasesCtrl(setup), setup)
        repository.addViewController(debug_ctrl.DebugController(), setup)
        repository.addViewController(default_maps_ctrl.DefaultMapsController(setup), setup)
        repository.addArenaViewController(battle_field_ctrl.BattleFieldCtrl(), setup)
        repository.addViewController(perk_ctrl.PerksController(), setup)
        repository.addViewController(battle_hints_ctrl.createBattleHintsController(), setup)
        repository.addArenaController(appearance_cache_ctrl.HalloweenAppearanceCacheController(setup), setup)
        repository.addArenaController(battle_gui_controller.HWBattleGUIController(), setup)
        repository.addController(personal_death_zones_gui_ctrl.PersonalDeathZonesGUIController())
        return repository