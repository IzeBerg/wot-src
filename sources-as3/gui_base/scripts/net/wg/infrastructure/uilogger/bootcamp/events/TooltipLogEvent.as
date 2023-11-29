package net.wg.infrastructure.uilogger.bootcamp.events
{
   import flash.events.Event;
   
   public class TooltipLogEvent extends Event
   {
      
      public static const SHOW_TOOLTIP:String = "showTooltip";
      
      public static const HIDE_TOOLTIP:String = "hideTooltip";
       
      
      public var key:String = "";
      
      public function TooltipLogEvent(param1:String, param2:String = "", param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.key = param2;
      }
      
      override public function clone() : Event
      {
         return new TooltipLogEvent(type,this.key,bubbles,cancelable);
      }
   }
}
