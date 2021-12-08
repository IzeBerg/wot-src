package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventStatsMeta extends IEventDispatcher
   {
       
      
      function as_updatePlayerStats(param1:Array) : void;
      
      function as_updateTitle(param1:String, param2:String) : void;
   }
}
