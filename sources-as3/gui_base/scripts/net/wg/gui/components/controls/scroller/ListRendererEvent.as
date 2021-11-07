package net.wg.gui.components.controls.scroller
{
   import flash.events.Event;
   
   public class ListRendererEvent extends Event
   {
      
      public static const RENDERER_ADD:String = "rendererAdd";
      
      public static const RENDERER_REMOVE:String = "rendererRemove";
      
      public static const SELECT:String = "rendererSelect";
      
      public static const CHANGE_SIZE:String = "changeSize";
       
      
      private var _data:Object = null;
      
      public function ListRendererEvent(param1:String, param2:Object = null)
      {
         super(param1);
         this._data = param2;
      }
      
      override public function clone() : Event
      {
         return new ListRendererEvent(type,this._data);
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}
