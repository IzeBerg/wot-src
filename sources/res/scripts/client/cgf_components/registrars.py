from constants import IS_EDITOR, IS_CLIENT
from cgf_script.managers_registrator import registerManager, registerRule, Rule
if IS_EDITOR:

    @registerRule
    class EventBattleRule(Rule):
        category = 'GameLogic'


    @registerRule
    class WTSoundsRule(Rule):
        category = 'GameLogic'


if IS_CLIENT:
    from cgf_components import wt_sounds_manager
    from cgf_components.arena_manager import ArenaManager
    from cgf_components.sound_manager import SoundComponentManager
    from cgf_components.escape_ability import AnimatorEventManager

    @registerRule
    class EventBattleRule(Rule):
        category = 'GameLogic'

        @registerManager(AnimatorEventManager)
        def reg1(self):
            return

        @registerManager(ArenaManager)
        def reg2(self):
            return


    @registerRule
    class WTSoundsRule(Rule):
        category = 'GameLogic'

        @registerManager(SoundComponentManager)
        def reg1(self):
            return

        @registerManager(wt_sounds_manager.LanguageSwitchManager)
        def reg2(self):
            return

        @registerManager(wt_sounds_manager.VehicleSwitchManager)
        def reg3(self):
            return

        @registerManager(wt_sounds_manager.EndBattleSoundManager)
        def reg4(self):
            return

        @registerManager(wt_sounds_manager.VehicleKilledSoundManager)
        def reg5(self):
            return

        @registerManager(wt_sounds_manager.GeneratorCaptureSoundManager)
        def reg6(self):
            return

        @registerManager(wt_sounds_manager.PlayerExperienceSwitchManager)
        def reg7(self):
            return

        @registerManager(wt_sounds_manager.ShieldSoundManager)
        def reg8(self):
            return

        @registerManager(wt_sounds_manager.BossAbilitySoundManager)
        def reg9(self):
            return

        @registerManager(wt_sounds_manager.ShootingSoundManager)
        def reg11(self):
            return

        @registerManager(wt_sounds_manager.SpawnSoundManager)
        def reg12(self):
            return

        @registerManager(wt_sounds_manager.GameplayEnterSoundPlayer)
        def reg13(self):
            return