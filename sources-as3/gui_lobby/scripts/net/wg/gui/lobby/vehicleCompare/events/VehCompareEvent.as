package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehCompareEvent extends Event
   {
      
      public static const CLOSE_CLICK:String = "closeClick";
      
      public static const BACK_CLICK:String = "backClick";
      
      public static const REMOVE_ALL_CLICK:String = "removeAllClick";
      
      public static const ADD:String = "addToCompare";
       
      
      public function VehCompareEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
