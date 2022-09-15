package net.wg.gui.lobby.eventBoards.events
{
   import flash.events.Event;
   
   public class FilterRendererEvent extends Event
   {
      
      public static const ITEM_CLICK:String = "rendererClick";
       
      
      private var _index:int = -1;
      
      private var _id:int = -1;
      
      public function FilterRendererEvent(param1:String, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._index = param2;
         this._id = param3;
      }
      
      override public function clone() : Event
      {
         return new FilterRendererEvent(type,this._index,this._id,bubbles,cancelable);
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function get id() : int
      {
         return this._id;
      }
   }
}
