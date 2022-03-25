package net.wg.gui.battle.views.staticMarkers.commander.orders
{
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class RTSOrderVehicleNameAnimation extends BattleUIComponent
   {
       
      
      public var vName:RTSOrderVehicleName = null;
      
      public function RTSOrderVehicleNameAnimation()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.vName.dispose();
         this.vName = null;
         super.onDispose();
      }
      
      public function setVehicleName(param1:String) : void
      {
         this.vName.textTF.text = param1;
      }
   }
}
