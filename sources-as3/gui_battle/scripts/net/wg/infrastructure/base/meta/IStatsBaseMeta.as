package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStatsBaseMeta extends IEventDispatcher
   {
       
      
      function acceptSquadS(param1:String) : void;
      
      function addToSquadS(param1:String, param2:String = "") : void;
      
      function as_setIsInteractive(param1:Boolean) : void;
   }
}
