package net.wg.gui.lobby.settings.vo.config.feedback
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class BattleEventInfoDataVo extends SettingsDataVo
   {
       
      
      public var battleEventsShowInBattle:SettingsControlProp = null;
      
      public var battleEventsReceivedDamage:SettingsControlProp = null;
      
      public var battleEventsReceivedCrits:SettingsControlProp = null;
      
      public var battleEventsEnemyHpDamage:SettingsControlProp = null;
      
      public var battleEventsEnemyBurning:SettingsControlProp = null;
      
      public var battleEventsEnemyRamAttack:SettingsControlProp = null;
      
      public var battleEventsBlockedDamage:SettingsControlProp = null;
      
      public var battleEventsEnemyDetectionDamage:SettingsControlProp = null;
      
      public var battleEventsEnemyTrackDamage:SettingsControlProp = null;
      
      public var battleEventsEnemyDetection:SettingsControlProp = null;
      
      public var battleEventsEnemyKill:SettingsControlProp = null;
      
      public var battleEventsBaseCaptureDrop:SettingsControlProp = null;
      
      public var battleEventsBaseCapture:SettingsControlProp = null;
      
      public var battleEventsEnemyCriticalHit:SettingsControlProp = null;
      
      public var battleEventsEnemyWorldCollision:SettingsControlProp = null;
      
      public var battleEventsEnemyAssistStun:SettingsControlProp = null;
      
      public var battleEventsCrewPerks:SettingsControlProp = null;
      
      public var battleEventsEventName:SettingsControlProp = null;
      
      public var battleEventsVehicleInfo:SettingsControlProp = null;
      
      public function BattleEventInfoDataVo()
      {
         super({
            "battleEventsReceivedDamage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsReceivedCrits":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsShowInBattle":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEnemyHpDamage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEnemyBurning":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEnemyRamAttack":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsBlockedDamage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEnemyDetectionDamage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEnemyTrackDamage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEnemyDetection":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEnemyKill":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsBaseCaptureDrop":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsBaseCapture":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEnemyCriticalHit":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEventName":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsVehicleInfo":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEnemyWorldCollision":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsEnemyAssistStun":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleEventsCrewPerks":createControl(ControlsFactory.TYPE_CHECKBOX).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.battleEventsReceivedDamage = null;
         this.battleEventsReceivedCrits = null;
         this.battleEventsShowInBattle = null;
         this.battleEventsEnemyHpDamage = null;
         this.battleEventsEnemyBurning = null;
         this.battleEventsEnemyRamAttack = null;
         this.battleEventsBlockedDamage = null;
         this.battleEventsEnemyDetectionDamage = null;
         this.battleEventsEnemyTrackDamage = null;
         this.battleEventsEnemyDetection = null;
         this.battleEventsEnemyKill = null;
         this.battleEventsBaseCaptureDrop = null;
         this.battleEventsBaseCapture = null;
         this.battleEventsEnemyCriticalHit = null;
         this.battleEventsEventName = null;
         this.battleEventsVehicleInfo = null;
         this.battleEventsEnemyWorldCollision = null;
         this.battleEventsEnemyAssistStun = null;
         this.battleEventsCrewPerks = null;
         super.onDispose();
      }
   }
}
