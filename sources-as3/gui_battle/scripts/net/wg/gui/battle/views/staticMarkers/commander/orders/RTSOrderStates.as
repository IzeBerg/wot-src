package net.wg.gui.battle.views.staticMarkers.commander.orders
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class RTSOrderStates extends BattleUIComponent
   {
      
      private static const REGULAR_ORDER_ICON_Y_OFFSET:int = -172;
      
      private static const NO_VEH_NAME_ORDER_ICON_Y_OFFSET:int = -138;
       
      
      public var vehNameAnim:RTSOrderVehicleNameAnimation = null;
      
      public var orderIconAnim:RTSOrderIconAnimation = null;
      
      public var pointAndLineAnim:MovieClip = null;
      
      public function RTSOrderStates()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.orderIconAnim.dispose();
         this.orderIconAnim = null;
         this.vehNameAnim.dispose();
         this.vehNameAnim = null;
         this.pointAndLineAnim = null;
         super.onDispose();
      }
      
      public function setOrderID(param1:Number, param2:Boolean) : void
      {
         this.orderIconAnim.setOrder(param1);
         if(param2)
         {
            this.orderIconAnim.y = REGULAR_ORDER_ICON_Y_OFFSET;
         }
         else
         {
            this.orderIconAnim.y = NO_VEH_NAME_ORDER_ICON_Y_OFFSET;
         }
      }
      
      public function setVehicleName(param1:String) : void
      {
         this.vehNameAnim.setVehicleName(param1);
      }
   }
}
