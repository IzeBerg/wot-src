package net.wg.gui.battle.commander.views.spawnMenu.events
{
   import flash.events.Event;
   
   public class EntryEvent extends Event
   {
      
      public static const FOCUS:String = "entryFocus";
      
      public static const SELECT:String = "entrySelect";
       
      
      public var value:Boolean;
      
      public var entryType:int;
      
      public var itemID:String;
      
      public var vehicleID:Number;
      
      public var entryID:String;
      
      public function EntryEvent(param1:String, param2:Boolean, param3:int, param4:String, param5:Number, param6:String)
      {
         super(param1,true);
         this.value = param2;
         this.entryType = param3;
         this.itemID = param4;
         this.vehicleID = param5;
         this.entryID = param6;
      }
      
      override public function clone() : Event
      {
         return new EntryEvent(type,this.value,this.entryType,this.itemID,this.vehicleID,this.entryID);
      }
      
      override public function toString() : String
      {
         return formatToString("EntryEvent","value","entryType","itemID","vehicleID","entryID");
      }
   }
}
