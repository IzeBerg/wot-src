package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationTabEvent extends Event
   {
      
      public static const TAB_CHANGED:String = "tabChangedEvent";
      
      public static const RETURN_TO_COMPLETE_STYLE:String = "returnToCompleteStyle";
       
      
      private var _groupId:int = -1;
      
      public function CustomizationTabEvent(param1:String, param2:int, param3:Boolean = false)
      {
         super(param1,param3);
         this._groupId = param2;
      }
      
      override public function clone() : Event
      {
         return new CustomizationTabEvent(type,this._groupId,bubbles);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomizationTabEvent","type","groupId");
      }
      
      public function get groupId() : int
      {
         return this._groupId;
      }
   }
}
