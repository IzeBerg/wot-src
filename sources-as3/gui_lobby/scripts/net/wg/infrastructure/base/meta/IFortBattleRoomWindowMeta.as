package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFortBattleRoomWindowMeta extends IEventDispatcher
   {
       
      
      function onBrowseClanBattlesS() : void;
      
      function onJoinClanBattleS(param1:Number, param2:int, param3:Number) : void;
      
      function onCreatedBattleRoomS(param1:Number, param2:Number) : void;
      
      function refreshS() : void;
      
      function as_setWindowTitle(param1:String) : void;
      
      function as_setWaiting(param1:Boolean, param2:String) : void;
      
      function as_setInfo(param1:Boolean, param2:String, param3:String) : void;
   }
}
