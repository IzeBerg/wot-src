package net.wg.gui.events
{
   import flash.events.Event;
   
   public class VehicleSellDialogEvent extends Event
   {
      
      public static const LIST_WAS_DRAWN:String = "listWasDrawn";
      
      public static const SELL_DIALOG_LIST_ITEM_RENDERER_WAS_DRAWN:String = "sellDialogListItemRendererWasDrawn";
      
      public static const SELECTION_CHANGED:String = "selectionChanged";
       
      
      public var listVisibleHight:Number;
      
      public var itemIDList:Array;
      
      public var toInventory:Boolean;
      
      public var currency:String;
      
      public function VehicleSellDialogEvent(param1:String, param2:Number = 0, param3:Array = null, param4:Boolean = true, param5:String = null)
      {
         super(param1,true,true);
         this.listVisibleHight = param2;
         this.itemIDList = param3;
         this.toInventory = param4;
         this.currency = param5;
      }
      
      override public function clone() : Event
      {
         return new VehicleSellDialogEvent(type,this.listVisibleHight,this.itemIDList,this.toInventory,this.currency);
      }
   }
}
