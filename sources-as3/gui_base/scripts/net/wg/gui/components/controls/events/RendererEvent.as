package net.wg.gui.components.controls.events
{
   import flash.events.Event;
   
   public class RendererEvent extends Event
   {
      
      public static const ITEM_CLICK:String = "rendererClick";
       
      
      private var _index:int;
      
      public function RendererEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._index = param2;
      }
      
      override public function clone() : Event
      {
         return new RendererEvent(type,this._index,bubbles,cancelable);
      }
      
      public function get index() : int
      {
         return this._index;
      }
   }
}
