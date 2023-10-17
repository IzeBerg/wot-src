from account_helpers.settings_core.settings_constants import BATTLE_EVENTS
from halloween.gui.scaleform.daapi.view.battle import ribbons_aggregator
from gui.Scaleform.daapi.view.battle.shared.ribbons_aggregator import DAMAGE_SOURCE
from gui.Scaleform.daapi.view.battle.shared.ribbons_panel import BattleRibbonsPanel
from halloween.gui.scaleform.genConsts.HW_BATTLE_EFFICIENCY_TYPES import HW_BATTLE_EFFICIENCY_TYPES
from halloween.gui.hw_vehicle_role_helper import getVehicleRole
from gui.impl import backport
from gui.impl.gen import R

class HWBattleRibbonsPanel(BattleRibbonsPanel):

    def __init__(self):
        super(HWBattleRibbonsPanel, self).__init__()
        self._ribbonsAggregator = ribbons_aggregator.createRibbonsAggregator()
        battleEfficiencyTypes = [ ribbon.TYPE for ribbon in ribbons_aggregator.HWReceiveDamageRibbonsFactory.ATTACK_REASONS.itervalues() ]
        self._ribbonsUserSettings = {BATTLE_EVENTS.RECEIVED_DAMAGE: battleEfficiencyTypes}

    def clear(self):
        self._ribbonsAggregator.clearRibbonsData()
        self.as_resetS()

    @property
    def aggregator(self):
        return self._ribbonsAggregator

    def _populate(self):
        super(HWBattleRibbonsPanel, self)._populate()
        for settingName in self._ribbonsUserSettings:
            self.__setUserSettings(settingName, bool(self.settingsCore.getSetting(settingName)))

        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched += self._onPostMortemSwitched
            ctrl.onRespawnBaseMoving += self._onRespawnBaseMoving
        return

    def _dispose(self):
        super(HWBattleRibbonsPanel, self)._dispose()
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched -= self._onPostMortemSwitched
            ctrl.onRespawnBaseMoving -= self._onRespawnBaseMoving
        return

    def _onPostMortemSwitched(self, noRespawnPossible, respawnAvailable):
        self.aggregator.suspend()
        self.clear()

    def _onRespawnBaseMoving(self):
        self.aggregator.resume()

    def _getRibbonsConfig(self):
        result = super(HWBattleRibbonsPanel, self)._getRibbonsConfig()
        result.extend([
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_DMG_VAMPIRE,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.damageVampire())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_AOE_BURN,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.aoeBurn())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_AOE_DAMAGE,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.aoeDamage())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_REPAIR,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.repair())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_REPAIR_OTHER,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.repairOther())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_REPAIR_BY_OTHER,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.repairByOther())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_MODULES_DAMAGE_BLOCKED,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.modulesDamageBlocked())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_PASSIVE_IGNITE,
          backport.text(R.strings.ingame_gui.efficiencyRibbons.burn())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_PASSIVE_VAMPIRE,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.passiveVampire())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_AOE_BOSS_BURN,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.bossAuraDamage())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_BOMBER_EXPLOSION,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.bomberExplosion())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_SHELLS_PICKUP,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.shellsPickup())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_DMG_VAMPIRE_RECEIVED,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.damageVampire())],
         [
          HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_AOE_DAMAGE_RECEIVED,
          backport.text(R.strings.halloween_battle.efficiencyRibbons.aoeDamage())]])
        return result

    def _getRibbonFormatter(self, ribbon):
        formatter = super(HWBattleRibbonsPanel, self)._getRibbonFormatter(ribbon)

        def hwSingleVehRibbonFormatter(ribbon, arenaDP, updater):

            def hwUpdater(*args, **kwargs):
                vehicleId = None
                if kwargs.get('vehType', DAMAGE_SOURCE.HIDE) != DAMAGE_SOURCE.HIDE:
                    if hasattr(ribbon, 'getVehicleID'):
                        vehicleId = ribbon.getVehicleID()
                    elif hasattr(ribbon, 'getVehIDs'):
                        vehicleId = ribbon.getVehIDs()[0]
                if vehicleId is not None:
                    vInfo = arenaDP.getVehicleInfo(vehicleId)
                    vehicleType = vInfo.vehicleType
                    role = getVehicleRole(vehicleType)
                    if role is not None:
                        kwargs['vehType'] = role
                    if vInfo.isEnemy():
                        kwargs['vehName'] = vehicleType.name
                updater(*args, **kwargs)
                return

            formatter(ribbon, arenaDP, hwUpdater)

        return hwSingleVehRibbonFormatter

    def _onSettingsChanged(self, diff):
        super(HWBattleRibbonsPanel, self)._onSettingsChanged(diff)
        for item in diff:
            if item in self._ribbonsUserSettings:
                self.__setUserSettings(item, bool(diff[item]))

    def __setUserSettings(self, settingName, value):
        ribbonTypes = self._ribbonsUserSettings.get(settingName, [])
        for rType in ribbonTypes:
            self.userPreferences[rType] = value