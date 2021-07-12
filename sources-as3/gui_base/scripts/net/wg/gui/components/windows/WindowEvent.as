package net.wg.gui.components.windows
{
   import flash.events.Event;
   
   public class WindowEvent extends Event
   {
      
      public static const SCALE_X_CHANGED:String = "scaleXChanged";
      
      public static const SCALE_Y_CHANGED:String = "scaleYChanged";
       
      
      public var prevValue:Number = 0;
      
      public function WindowEvent(param1:String, param2:Number)
      {
         super(param1,true,false);
         this.prevValue = param2;
      }
   }
}
