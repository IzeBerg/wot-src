package net.wg.gui.battle.views.damagePanel.components.tankIndicator
{
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   
   public class WheelTurret extends ItemWithModules
   {
       
      
      public var turretRotator:DamagePanelItemFrameStates;
      
      public var gun:DamagePanelItemFrameStates;
      
      public function WheelTurret()
      {
         super();
      }
      
      override protected function getModules() : Vector.<DamagePanelItemFrameStates>
      {
         return new <DamagePanelItemFrameStates>[this.turretRotator,this.gun];
      }
      
      override protected function onDispose() : void
      {
         this.turretRotator.dispose();
         this.turretRotator = null;
         this.gun.dispose();
         this.gun = null;
         super.onDispose();
      }
   }
}
