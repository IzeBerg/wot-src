package net.wg.gui.components.wulf
{
   import flash.events.Event;
   
   public class ChildViewProxyEvent extends Event
   {
      
      public static const PLACE_ADDED:String = "wulfChildPlaceAdded";
      
      public static const PLACE_REMOVED:String = "wulfChildPlaceRemoved";
       
      
      private var _placeId:uint;
      
      public function ChildViewProxyEvent(param1:String, param2:uint)
      {
         super(param1,true,false);
         this._placeId = param2;
      }
      
      override public function clone() : Event
      {
         return new ChildViewProxyEvent(type,this._placeId);
      }
      
      public function get placeId() : uint
      {
         return this._placeId;
      }
   }
}
