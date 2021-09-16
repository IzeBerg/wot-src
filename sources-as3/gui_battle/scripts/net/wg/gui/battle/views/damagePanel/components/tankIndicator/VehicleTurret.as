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
         var _loc1_:Vector.<DamagePanelItemFrameStates> = new <DamagePanelItemFrameStates>[this.turretRotator,this.gun,this.radio,this.surveyingDevice];
         if(this.ammoBay != null)
         {
            _loc1_.push(this.ammoBay);
         }
         return _loc1_;
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
         if(this.ammoBay)
         {
            this.ammoBay.dispose();
            this.ammoBay = null;
         }
         super.onDispose();
      }
   }
}
