import typing
from gui.battle_control.controllers import battle_field_ctrl, debug_ctrl, team_bases_ctrl, default_maps_ctrl, perk_ctrl, personal_death_zones_gui_ctrl
from gui.battle_control.controllers.battle_hints import controller as battle_hints_ctrl
from gui.battle_control.controllers.repositories import ControllersRepositoryByBonuses, SharedControllersRepository
from gui.battle_control.controllers.sound_ctrls.common import ShotsResultSoundController
from halloween.gui.battle_control.controllers import appearance_cache_ctrl
from halloween.gui.battle_control.controllers import battle_gui_controller
from halloween.gui.battle_control.controllers import defence_battle_gui_controller
if typing.TYPE_CHECKING:
    from gui.battle_control import BattleSessionSetup
    from gui.battle_control.controllers import _ControllersRepository

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
        repository.addViewController(battle_hints_ctrl.BattleHintsController(), setup)
        repository.addArenaController(appearance_cache_ctrl.HalloweenAppearanceCacheController(setup), setup)
        repository.addArenaController(battle_gui_controller.HWBattleGUIController(), setup)
        repository.addController(personal_death_zones_gui_ctrl.PersonalDeathZonesGUIController())
        repository.addController(ShotsResultSoundController())
        return repository


class HalloweenSharedControllersRepository(SharedControllersRepository):
    pass


class HalloweenDefenceControllerRepository(ControllersRepositoryByBonuses):
    __slots__ = ()

    @classmethod
    def create(cls, setup):
        repository = super(HalloweenDefenceControllerRepository, cls).create(setup)
        repository.addArenaViewController(team_bases_ctrl.createTeamsBasesCtrl(setup), setup)
        repository.addViewController(debug_ctrl.DebugController(), setup)
        repository.addViewController(default_maps_ctrl.DefaultMapsController(setup), setup)
        repository.addArenaViewController(battle_field_ctrl.BattleFieldCtrl(), setup)
        repository.addViewController(perk_ctrl.PerksController(), setup)
        repository.addViewController(battle_hints_ctrl.BattleHintsController(), setup)
        repository.addArenaController(appearance_cache_ctrl.HalloweenAppearanceCacheController(setup), setup)
        repository.addArenaController(defence_battle_gui_controller.HWDefenceBattleGUIController(), setup)
        repository.addController(personal_death_zones_gui_ctrl.PersonalDeathZonesGUIController())
        repository.addController(ShotsResultSoundController())
        return repository