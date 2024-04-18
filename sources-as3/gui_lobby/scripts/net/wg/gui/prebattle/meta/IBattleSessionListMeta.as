package net.wg.gui.prebattle.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleSessionListMeta extends IEventDispatcher
   {
       
      
      function requestToJoinTeamS(param1:Number, param2:Number) : void;
      
      function getClientIDS() : Number;
      
      function as_refreshList(param1:Array) : void;
   }
}
