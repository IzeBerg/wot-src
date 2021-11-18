package net.wg.gui.lobby.eventBoards.events
{
   import flash.events.Event;
   
   public class PlayerRendererEvent extends Event
   {
      
      public static const PLAYER_CLICK:String = "playerClick";
       
      
      private var _id:Number;
      
      public function PlayerRendererEvent(param1:String, param2:Number, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._id = param2;
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      override public function clone() : Event
      {
         return new PlayerRendererEvent(type,this.id);
      }
      
      override public function toString() : String
      {
         return formatToString("PlayerRendererEvent","type","id","bubbles","cancelable");
      }
   }
}
