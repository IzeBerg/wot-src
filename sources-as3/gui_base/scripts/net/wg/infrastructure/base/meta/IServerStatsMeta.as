package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IServerStatsMeta extends IEventDispatcher
   {
       
      
      function reloginS(param1:int) : void;
      
      function startListenCsisUpdateS(param1:Boolean) : void;
      
      function as_changePeripheryFailed() : void;
      
      function as_disableRoamingDD(param1:Boolean) : void;
      
      function as_setServerStats(param1:String, param2:String) : void;
      
      function as_setServerStatsInfo(param1:String) : void;
      
      function as_getServersDP() : Object;
      
      function as_setSelectedServerIndex(param1:int) : void;
   }
}
