package net.wg.gui.battle.views.staticMarkers.commander.orders
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RTSOrderMarker extends BattleUIComponent implements IDisposable
   {
      
      private static const DISABLED_ALPHA:Number = 0.5;
      
      private static const ENABLED_ALPHA:Number = 1;
       
      
      public var marker:RTSOrderStates = null;
      
      public function RTSOrderMarker()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function setOrderIDAndVehicleName(param1:Number, param2:String) : void
      {
         this.marker.setVehicleName(param2);
         this.marker.setOrderID(param1,param2 != "");
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         this.marker.alpha = !!param1 ? Number(ENABLED_ALPHA) : Number(DISABLED_ALPHA);
      }
      
      override protected function onDispose() : void
      {
         this.marker.dispose();
         this.marker = null;
         super.onDispose();
      }
   }
}
