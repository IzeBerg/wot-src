package net.wg.gui.lobby.components.events
{
   import flash.events.Event;
   
   public class DashLineTextItemRendererEvent extends Event
   {
      
      public static const TEXT_SIZE_CHANGED:String = "dashLineItemRendererTextSizeChanged";
       
      
      public function DashLineTextItemRendererEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new DashLineTextItemRendererEvent(type,bubbles,cancelable);
      }
   }
}
