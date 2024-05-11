package net.wg.gui.lobby.eventBoards.events
{
   import flash.events.Event;
   
   public class TypeEvent extends Event
   {
       
      
      private var _id:String = "";
      
      public function TypeEvent(param1:String, param2:String, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._id = param2;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      override public function clone() : Event
      {
         return new TypeEvent(type,this.id,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("EventIDEvent","type","id","bubbles","cancelable");
      }
   }
}
