package net.wg.gui.lobby.vehicleTradeWnds.buy.ev
{
   import flash.events.Event;
   
   public final class VehicleBuyEvent extends Event
   {
      
      public static const TOTAL_PRICE_UPDATED:String = "total_price_updated";
      
      public static const TAB_CHANGE:String = "on_tab_change";
      
      public static const SIZE_CHANGE:String = "on_size_change";
      
      public static const TRADE_IN_CLEAR_VEHICLE:String = "trade_in_clear_vehicle";
      
      public static const UPDATE_INTERFACE:String = "updateInterface";
       
      
      public var isSubmitSetFocus:Boolean = false;
      
      public var tabIndex:Number = -1;
      
      public function VehicleBuyEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Number = -1)
      {
         this.isSubmitSetFocus = param4;
         this.tabIndex = param5;
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new VehicleBuyEvent(type,bubbles,cancelable,this.isSubmitSetFocus,this.tabIndex);
      }
      
      override public function toString() : String
      {
         return formatToString("VehicleBuyEvent","type","bubbles","cancelable","isSubmitSetFocus","tabIndex");
      }
   }
}
