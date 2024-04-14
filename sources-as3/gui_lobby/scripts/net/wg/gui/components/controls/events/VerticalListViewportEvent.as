package net.wg.gui.components.controls.events
{
   import flash.events.Event;
   
   public class VerticalListViewportEvent extends Event
   {
      
      public static const RESIZE_TOP:String = "resizeTop";
      
      public static const RESIZE_BOTTOM:String = "resizeBottom";
       
      
      private var _change:int = 0;
      
      public function VerticalListViewportEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._change = param2;
      }
      
      override public function clone() : Event
      {
         return new VerticalListViewportEvent(type,this._change,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("VerticalListViewportEvent","type","bubbles","cancelable","eventPhase","change");
      }
      
      public function get change() : int
      {
         return this._change;
      }
   }
}
