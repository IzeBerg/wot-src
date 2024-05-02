package net.wg.gui.lobby.rankedBattles19.events
{
   import flash.events.Event;
   
   public class DivisionsEvent extends Event
   {
      
      public static const INDEX_CHANGED:String = "index_changed";
       
      
      public var index:int = -1;
      
      public function DivisionsEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.index = param2;
      }
      
      override public function clone() : Event
      {
         return new DivisionsEvent(type,this.index,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("DivisionsEvent","type","index","bubbles","cancelable");
      }
   }
}
