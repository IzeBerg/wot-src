package net.wg.gui.lobby.eventBoards.events
{
   import flash.events.Event;
   
   public class ServerEvent extends Event
   {
       
      
      private var _id:String = "";
      
      private var _server:String = "";
      
      public function ServerEvent(param1:String, param2:String, param3:String, param4:Boolean = true, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._id = param2;
         this._server = param3;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get server() : String
      {
         return this._server;
      }
      
      override public function clone() : Event
      {
         return new ServerEvent(type,this.id,this.server,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ServerEvent","type","id","server","bubbles","cancelable");
      }
   }
}
