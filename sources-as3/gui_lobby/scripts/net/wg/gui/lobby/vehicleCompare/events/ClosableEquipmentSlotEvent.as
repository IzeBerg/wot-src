package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class ClosableEquipmentSlotEvent extends Event
   {
      
      public static const LEFT_BTN_CLICK:String = "leftBtnClick";
      
      public static const RIGHT_BTN_CLICK:String = "rightBtnClick";
      
      public static const REMOVE_CLICK:String = "removeClick";
       
      
      public function ClosableEquipmentSlotEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
