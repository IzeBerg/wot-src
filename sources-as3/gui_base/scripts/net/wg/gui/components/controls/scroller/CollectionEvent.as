package net.wg.gui.components.controls.scroller
{
   import flash.events.Event;
   
   public class CollectionEvent extends Event
   {
      
      public static const CHANGE:String = "collectionChange";
       
      
      private var _kind:String = "";
      
      private var _location:Object = null;
      
      private var _data:Object = null;
      
      public function CollectionEvent(param1:String, param2:String, param3:Object = null, param4:Object = null)
      {
         super(param1);
         this._kind = param2;
         this._location = param3;
         this._data = param4;
      }
      
      override public function clone() : Event
      {
         return new CollectionEvent(type,this._kind,this._location,this._data);
      }
      
      public function get kind() : String
      {
         return this._kind;
      }
      
      public function get location() : Object
      {
         return this._location;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}
