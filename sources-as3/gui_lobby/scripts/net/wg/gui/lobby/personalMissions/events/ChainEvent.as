package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class ChainEvent extends Event
   {
      
      public static const CHAIN_CHANGED:String = "chainChanged";
      
      public static const CHAIN_INIT_COMPLETED:String = "chainInitCompleted";
       
      
      private var _btnIdx:int = -1;
      
      public function ChainEvent(param1:String, param2:int)
      {
         super(param1,false,false);
         this._btnIdx = param2;
      }
      
      override public function clone() : Event
      {
         return new ChainEvent(type,this._btnIdx);
      }
      
      public function get btnIdx() : int
      {
         return this._btnIdx;
      }
   }
}
