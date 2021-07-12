package net.wg.gui.battle.views.damagePanel.components.tankIndicator
{
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   
   public class VehicleTurret extends ItemWithModules
   {
       
      
      public var turretRotator:DamagePanelItemFrameStates;
      
      public var gun:DamagePanelItemFrameStates;
      
      public var radio:DamagePanelItemFrameStates;
      
      public var surveyingDevice:DamagePanelItemFrameStates;
      
      public var ammoBay:DamagePanelItemFrameStates;
      
      public function VehicleTurret()
      {
         super();
      }
      
      override protected function getModules() : Vector.<DamagePanelItemFrameStates>
      {
         return new <DamagePanelItemFrameStates>[this.turretRotator,this.gun,this.radio,this.surveyingDevice,this.ammoBay];
      }
      
      override protected function onDispose() : void
      {
         this.turretRotator.dispose();
         this.turretRotator = null;
         this.gun.dispose();
         this.gun = null;
         this.radio.dispose();
         this.radio = null;
         this.surveyingDevice.dispose();
         this.surveyingDevice = null;
         this.ammoBay.dispose();
         this.ammoBay = null;
         super.onDispose();
      }
   }
}
