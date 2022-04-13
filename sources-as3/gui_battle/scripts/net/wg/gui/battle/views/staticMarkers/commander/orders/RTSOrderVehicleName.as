package net.wg.gui.battle.views.staticMarkers.commander.orders
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class RTSOrderVehicleName extends BattleUIComponent
   {
       
      
      public var textTF:TextField = null;
      
      public function RTSOrderVehicleName()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.textTF = null;
         super.onDispose();
      }
   }
}
