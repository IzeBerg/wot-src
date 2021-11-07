package net.wg.gui.notification.events
{
   import flash.events.Event;
   
   public class ServiceMessageEvent extends Event
   {
      
      public static const MESSAGE_AREA_CLICKED:String = "msgClicked";
      
      public static const MESSAGE_BUTTON_CLICKED:String = "msgBtnClicked";
      
      public static const MESSAGE_LINK_CLICKED:String = "msgLinkClicked";
       
      
      public var typeID:uint;
      
      public var entityID:Number;
      
      public var action:String;
      
      public function ServiceMessageEvent(param1:String, param2:uint, param3:Number, param4:Boolean = false, param5:Boolean = false, param6:String = "")
      {
         super(param1,param4,param5);
         this.typeID = param2;
         this.entityID = param3;
         this.action = param6;
      }
      
      override public function clone() : Event
      {
         return new ServiceMessageEvent(type,this.typeID,this.entityID,bubbles,cancelable,this.action);
      }
      
      override public function toString() : String
      {
         return formatToString("ServiceMessageEvent","type","bubbles","cancelable","eventPhase","typeID","entityID","action");
      }
   }
}
