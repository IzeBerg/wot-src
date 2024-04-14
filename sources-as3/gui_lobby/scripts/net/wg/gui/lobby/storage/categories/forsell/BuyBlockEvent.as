package net.wg.gui.lobby.storage.categories.forsell
{
   import flash.events.Event;
   
   public class BuyBlockEvent extends Event
   {
      
      public static const SELECT_ALL:String = "selectAll";
      
      public static const DESELECT_ALL:String = "deselectAll";
      
      public static const SELL:String = "sell";
       
      
      public function BuyBlockEvent(param1:String)
      {
         super(param1,false,false);
      }
      
      override public function clone() : Event
      {
         return new BuyBlockEvent(type);
      }
      
      override public function toString() : String
      {
         return formatToString("BuyBlockEvent","type");
      }
   }
}
