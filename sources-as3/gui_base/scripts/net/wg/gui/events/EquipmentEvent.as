package net.wg.gui.events
{
   import flash.events.Event;
   
   public class EquipmentEvent extends Event
   {
      
      public static const NEED_UPDATE:String = "needUpdate";
      
      public static const EQUIPMENT_CHANGE:String = "equipmentChange";
      
      public static const TOTAL_PRICE_CHANGED:String = "totalPriceChanged";
       
      
      public var changeIndex:int = -1;
      
      public var changeCurrency:String = "";
      
      public var itemId:String = "";
      
      public function EquipmentEvent(param1:String, param2:int = -1, param3:String = "", param4:String = "")
      {
         super(param1,true,true);
         this.changeIndex = param2;
         this.changeCurrency = param3;
         this.itemId = param4;
      }
      
      override public function clone() : Event
      {
         return new EquipmentEvent(type,this.changeIndex,this.changeCurrency,this.itemId);
      }
   }
}
