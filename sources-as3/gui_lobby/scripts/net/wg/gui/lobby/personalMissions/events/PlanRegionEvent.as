package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class PlanRegionEvent extends Event
   {
      
      public static const CLICK:String = "Click";
       
      
      private var _id:Number = -1;
      
      public function PlanRegionEvent(param1:String, param2:Number, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._id = param2;
      }
      
      override public function clone() : Event
      {
         return new PlanRegionEvent(type,this.id,bubbles,cancelable);
      }
      
      public function get id() : Number
      {
         return this._id;
      }
   }
}
