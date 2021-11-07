package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class ListDataProviderEvent extends Event
   {
      
      public static var UPDATE_ITEM:String = "updateItem";
      
      public static var RESET_SELECTED_INDEX:String = "resetSelectedIndex";
      
      public static var VALIDATE_ITEMS:String = "validateItems";
       
      
      private var _index:int;
      
      private var _data:Object;
      
      public function ListDataProviderEvent(param1:String, param2:int, param3:Object)
      {
         super(param1,false,false);
         this._index = param2;
         this._data = param3;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function get index() : int
      {
         return this._index;
      }
   }
}
