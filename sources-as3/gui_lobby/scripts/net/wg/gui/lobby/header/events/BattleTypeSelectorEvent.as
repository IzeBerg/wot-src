package net.wg.gui.lobby.header.events
{
   import flash.events.Event;
   
   public class BattleTypeSelectorEvent extends Event
   {
      
      public static var BATTLE_TYPE_ITEM_EVENT:String = "BATTLE_TYPE_ITEM_EVENT";
      
      public static var ITEM_ID_DEMO_CLICK:String = "demoIdDemoClick";
       
      
      public var itemId:String = "";
      
      public var data:Object = null;
      
      public function BattleTypeSelectorEvent(param1:String, param2:String, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.itemId = param2;
         this.data = param3;
      }
      
      override public function clone() : Event
      {
         return new BattleTypeSelectorEvent(type,this.itemId,this.data,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("BattleTypeSelectorEvent","type","itemId","data","bubbles","cancelable");
      }
   }
}
